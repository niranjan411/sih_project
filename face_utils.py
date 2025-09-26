import os
import cv2
import numpy as np
from mtcnn.mtcnn import MTCNN
from PIL import Image
from keras_facenet import FaceNet
from datetime import datetime

# -------------------------------
# Initialize detector & embedder
# -------------------------------
detector = MTCNN()
embedder = FaceNet()

# -------------------------------
# Similarity
# -------------------------------
def cosine_similarity(a, b):
    """Compute cosine similarity between two embeddings"""
    a, b = np.array(a).flatten(), np.array(b).flatten()
    return np.dot(a, b) / (np.linalg.norm(a) * np.linalg.norm(b))

# -------------------------------
# Face Extraction
# -------------------------------
def extract_faces(filename, required_size=(160, 160), resize_image=None):
    """Detect faces in an image file and return list of face arrays"""
    image = Image.open(filename).convert("RGB")
    if resize_image and (image.size[0] > 2000 or image.size[1] > 2000):
        image = image.resize(resize_image)
    pixels = np.asarray(image)
    results = detector.detect_faces(pixels)

    faces = []
    for result in results:
        x1, y1, w, h = result['box']
        x1, y1 = max(0, x1), max(0, y1)
        x2, y2 = x1 + w, y1 + h
        face_img = np.asarray(Image.fromarray(pixels[y1:y2, x1:x2]).resize(required_size))
        faces.append(face_img)
    return faces

# -------------------------------
# Embeddings
# -------------------------------
def get_embedding(face_pixels):
    """Return L2-normalized embedding for a single face"""
    face_pixels = face_pixels.astype('float32')
    samples = np.expand_dims(face_pixels, axis=0)
    emb = embedder.embeddings(samples)[0]
    return emb / np.linalg.norm(emb)

def get_embeddings_batch(faces):
    """Compute embeddings for multiple faces"""
    if len(faces) == 0:
        return []
    faces = np.asarray(faces).astype('float32')
    yhat = embedder.embeddings(faces)
    return [emb / np.linalg.norm(emb) for emb in yhat]

# -------------------------------
# Enrollment
# -------------------------------
def add_student_embeddings(student_name, image_paths, embeddings_file="student_embeddings.npz"):
    """Add a student with multiple images and store embeddings"""
    faces = []
    for path in image_paths:
        faces.extend(extract_faces(path))
    if not faces:
        print(f"⚠️ No valid faces for {student_name}")
        return

    embeddings = get_embeddings_batch(faces)
    avg_emb = np.mean(embeddings, axis=0)
    avg_emb /= np.linalg.norm(avg_emb)

    if os.path.exists(embeddings_file):
        data = np.load(embeddings_file, allow_pickle=True)
        student_embeddings = dict(data.items())
    else:
        student_embeddings = {}

    student_embeddings[student_name] = {"avg": avg_emb, "all": np.array(embeddings)}
    np.savez(embeddings_file, **student_embeddings)
    print(f"✅ Added/Updated {student_name} ({len(embeddings)} faces)")

# -------------------------------
# Recognition in Video
# -------------------------------
def recognize_faces_in_frame(frame, student_embeddings, threshold=0.7):
    """Detect and recognize faces in a video frame"""
    results = detector.detect_faces(frame)
    recognized = []
    for result in results:
        x1, y1, w, h = result['box']
        x1, y1 = max(0, x1), max(0, y1)
        x2, y2 = x1 + w, y1 + h

        face_img = cv2.resize(frame[y1:y2, x1:x2], (160, 160))
        emb = get_embedding(face_img)

        best_match, highest_sim = "Not recognized", 0
        for student_name, db_data in student_embeddings.items():
            db_embs = db_data.get("all", [db_data["avg"]])
            sims = [cosine_similarity(emb, e) for e in db_embs]
            sim = max(sims) if sims else 0
            if sim > highest_sim:
                best_match, highest_sim = student_name, sim

        if highest_sim >= threshold:
            recognized.append((best_match, highest_sim, (x1, y1, x2, y2)))
        else:
            recognized.append(("Not recognized", highest_sim, (x1, y1, x2, y2)))
    return recognized

def mark_attendance_from_video(student_embeddings, video_source=0, threshold=0.7, duration=30):
    """Start webcam and mark attendance for duration seconds"""
    cap = cv2.VideoCapture(video_source)
    attendance = {}

    start_time = datetime.now()
    while (datetime.now() - start_time).seconds < duration:
        ret, frame = cap.read()
        if not ret:
            break

        rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        recognized = recognize_faces_in_frame(rgb_frame, student_embeddings, threshold)

        for name, sim, (x1, y1, x2, y2) in recognized:
            color = (0, 255, 0) if name != "Not recognized" else (0, 0, 255)
            cv2.rectangle(frame, (x1, y1), (x2, y2), color, 2)
            cv2.putText(frame, f"{name} ({sim:.2f})", (x1, y1-10),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.6, color, 2)
            if name != "Not recognized":
                attendance[name] = datetime.now().strftime("%H:%M:%S")

        cv2.imshow("Attendance System", frame)
        if cv2.waitKey(30) & 0xFF == ord('q'): #30 ms instead of 1
            break

    cap.release()
    cv2.destroyAllWindows()
    return attendance

# -------------------------------
# Absentees
# -------------------------------
def get_absent_students(student_embeddings, attendance_log):
    """Return list of students who were absent"""
    all_students = set(student_embeddings.keys())
    present_students = set(attendance_log.keys())
    absent_students = list(all_students - present_students)
    return absent_students

# -------------------------------
# Attendance by Image
# -------------------------------
def mark_attendance_from_images(student_embeddings, image_folder, threshold=0.7):
    """
    Process all images in a folder and mark attendance based on recognition.
    Returns attendance dictionary {student_name: timestamp}.
    """
    attendance = {}
    valid_exts = (".jpg", ".jpeg", ".png")

    for image_file in os.listdir(image_folder):
        if not image_file.lower().endswith(valid_exts):
            continue
        image_path = os.path.join(image_folder, image_file)
        if not os.path.isfile(image_path):
            continue

        # Load image
        image = Image.open(image_path).convert("RGB")
        pixels = np.asarray(image)

        # Detect faces
        results = detector.detect_faces(pixels)
        if len(results) == 0:
            print(f"⚠️ No faces found in {image_file}")
            continue

        for result in results:
            x1, y1, w, h = result['box']
            x1, y1 = max(0, x1), max(0, y1)
            x2, y2 = x1 + w, y1 + h

            face_np = np.asarray(Image.fromarray(pixels[y1:y2, x1:x2]).resize((160, 160)))
            emb = get_embedding(face_np)

            # Recognition
            best_match, highest_sim = "Not recognized", 0
            for student_name, db_data in student_embeddings.items():
                db_embs = db_data.get("all", [db_data["avg"]])
                sims = [cosine_similarity(emb, e) for e in db_embs]
                sim = max(sims) if sims else 0
                if sim > highest_sim:
                    best_match, highest_sim = student_name, sim

            if highest_sim >= threshold:
                attendance[best_match] = datetime.now().strftime("%H:%M:%S")
                print(f"✅ {best_match} recognized in {image_file} ({highest_sim:.2f})")
            else:
                print(f"❌ Face not recognized in {image_file}")

    return attendance
