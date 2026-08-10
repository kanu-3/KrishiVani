# KrishiVani

### AI-Powered Agricultural Assistant for Farmers

KrishiVani is an AI-powered agricultural assistance platform designed to help farmers identify plant diseases, understand crop health, access agricultural knowledge, analyze market conditions, and interact with an intelligent agricultural assistant.

The system combines a **Flutter mobile application**, **Supabase backend**, **CNN-based plant disease detection**, **RAG-based agricultural knowledge retrieval**, and **machine learning models for market analysis** into a unified platform.

---

## Core Features

### 1. Plant Disease Detection

KrishiVani allows farmers to capture or upload an image of a plant and identify potential diseases using a deep learning model.

The current disease detection pipeline uses **EfficientNetB0**, a convolutional neural network architecture trained for multi-class plant disease classification.

The system provides:

* Plant image upload/capture
* Image preprocessing
* CNN-based disease classification
* Disease prediction
* Prediction confidence
* Disease-specific symptoms and recommendations

---

### 2. AI Agricultural Chatbot

The KrishiVani chatbot is **not a generic conversational chatbot**.

It is designed specifically around agricultural assistance and combines multiple sources of context before generating an answer.

The chatbot can use:

* The farmer's text query
* Plant images
* Disease predicted by the CNN model
* Agricultural documents
* Retrieved information from the agricultural knowledge base
* Conversation context/memory

This creates a multimodal agricultural assistant capable of answering questions based on the **actual plant and disease being analyzed**, rather than providing generic responses.

#### Example Flow

```text
Farmer uploads plant image
          │
          ▼
     CNN Prediction
          │
          ▼
   Disease Identified
          │
          ├──────────────┐
          │              │
          ▼              ▼
 Plant/Disease      Agricultural
    Context          Documents
          │              │
          └──────┬───────┘
                 ▼
          RAG Retrieval
                 │
                 ▼
        Context Construction
                 │
                 ▼
          AI Chatbot
                 │
                 ▼
     Agricultural Guidance
```

---

### 3. Retrieval-Augmented Generation (RAG)

KrishiVani will implement a **Retrieval-Augmented Generation architecture** to ground the agricultural assistant in relevant agricultural information.

Agricultural documents will be processed, embedded, and stored in a vector-search system.

When a farmer asks a question, the system will:

1. Understand the user's query.
2. Retrieve relevant agricultural information.
3. Incorporate the CNN disease prediction and plant context when available.
4. Construct the context for the language model.
5. Generate a grounded response.

The RAG layer is intended to reduce generic or unsupported responses and provide answers based on relevant agricultural knowledge.

---

### 4. Market Analysis

KrishiVani will include a machine learning-based market analysis system for agricultural crops.

Rather than relying on a single algorithm, multiple machine learning models will be trained and evaluated to determine the best-performing approach for the available market dataset.

The model experimentation will include **XGBoost** along with other suitable machine learning algorithms.

The pipeline will involve:

```text
Market Dataset
      │
      ▼
Data Cleaning & Preprocessing
      │
      ▼
Feature Engineering
      │
      ▼
Multiple ML Models
      │
      ├── XGBoost
      ├── Random forest 
      │
      ▼
Model Evaluation & Comparison
      │
      ▼
Best Performing Model
      │
      ▼
Market Prediction
```

Models will be compared using appropriate evaluation metrics, and the best-performing model will be selected for deployment.

Potential outputs include:

* Crop price prediction
* Expected market trends
* Model confidence
* Market-based recommendations

---

### 5. User Profile

KrishiVani provides a user profile system backed by Supabase.

Users can:

* Create an account
* Manage profile information
* Update personal details
* Access their application data
* Maintain personalized agricultural interactions

---

### 6. Authentication

Authentication is implemented using **Supabase Auth**.

The authentication flow includes:

* Sign up
* Login
* Email verification
* OTP
* Forgot password
* Password reset

---

## Technology Stack

| Layer              | Technology            |
| ------------------ | --------------------- |
| Mobile Application | Flutter               |
| Language           | Dart                  |
| Backend & Database | Supabase              |
| Authentication     | Supabase Auth         |
| ML API             | FastAPI               |
| Deep Learning      | TensorFlow / Keras    |
| CNN Architecture   | EfficientNetB0        |
| Machine Learning   | Scikit-learn, XGBoost |
| ML Development     | Python                |
| Data Processing    | Pandas, NumPy         |
| Vector Search      | PostgreSQL / pgvector |
| AI Architecture    | RAG                   |
| Model Hosting      | Render                |
| Version Control    | Git / GitHub          |

---

## System Architecture

```text
                         ┌─────────────────────┐
                         │       Farmer        │
                         └──────────┬──────────┘
                                    │
                                    ▼
                         ┌─────────────────────┐
                         │   KrishiVani App    │
                         │       Flutter       │
                         └──────────┬──────────┘
                                    │
             ┌──────────────────────┼──────────────────────┐
             │                      │                      │
             ▼                      ▼                      ▼
       Supabase Backend       ML Inference API       AI Assistant
       Authentication              FastAPI                │
       User Profiles                 │                    │
       Application Data             ▼                    ▼
                             EfficientNetB0          RAG Pipeline
                                    │                    │
                                    ▼                    ▼
                             Disease Prediction    Vector Database
                                                         │
                                                         ▼
                                                Agricultural Documents
                                                         │
                                                         ▼
                                                   LLM Response
```

---

## Machine Learning

### Plant Disease Detection

The disease detection system uses **EfficientNetB0** for multi-class image classification.

Current dataset configuration:

* Approximately **54,000 images**
* **38 disease/plant classes**
* 70% training
* 15% validation
* 15% testing
* Input size: `256 × 256 × 3`

The current training pipeline uses TensorFlow/Keras.

The model has achieved approximately **98% validation accuracy** under the current evaluation setup.

---

## ML Disease Detection Pipeline

```text
Plant Image
     │
     ▼
Image Preprocessing
     │
     ▼
EfficientNetB0
     │
     ▼
Disease Classification
     │
     ▼
Disease + Confidence
     │
     ▼
Context for AI Assistant
     │
     ▼
RAG + Agricultural Knowledge
     │
     ▼
Personalized Guidance
```

---

## RAG Pipeline

```text
Agricultural Documents
          │
          ▼
    Document Processing
          │
          ▼
       Chunking
          │
          ▼
      Embeddings
          │
          ▼
 PostgreSQL + pgvector
          │
          │
User Query ─┘
    │
    ▼
Semantic Retrieval
    │
    ▼
Relevant Context
    │
    ├── User Query
    ├── Plant Image Context
    ├── CNN Disease Prediction
    └── Retrieved Documents
            │
            ▼
       Language Model
            │
            ▼
    Grounded Response
```

---

## Application Flow

```text
Launch
  │
  ▼
Onboarding
  │
  ▼
Authentication
  │
  ▼
Home
  │
  ├──────────────┬──────────────┬──────────────┐
  ▼              ▼              ▼              ▼
 Scan          Market          Chat          Profile
  │              │              │
  ▼              ▼              ▼
Plant Image   Market Data    User Query
  │              │              │
  ▼              ▼              │
CNN Model     ML Models        │
  │              │              │
  ▼              ▼              │
Disease       Best Model        │
Prediction    Prediction        │
  │                             │
  └──────────────┬──────────────┘
                 ▼
             AI Assistant
                 │
                 ▼
          RAG + Context
                 │
                 ▼
        Agricultural Guidance
```

---

## Flutter Architecture

The Flutter application follows a feature-oriented architecture.

```text
flutter_app/
│
├── lib/
│   ├── app/
│   │   └── router/
│   │
│   ├── core/
│   │   ├── constants/
│   │   ├── services/
│   │   ├── theme/
│   │   ├── utils/
│   │   └── widgets/
│   │
│   └── feature/
│       ├── auth/
│       ├── chat/
│       ├── home/
│       ├── market/
│       ├── onboarding/
│       ├── others/
│       ├── profile/
│       └── scan/
│
└── pubspec.yaml
```

---

## Project Structure

```text
KrishiVani/
│
├── flutter_app/
│   ├── android/
│   ├── ios/
│   ├── assets/
│   ├── lib/
│   └── pubspec.yaml
│
├── ml/
│   └── notebooks/
│       ├── Preprocessing.ipynb
│       └── Training_and_testing.ipynb
│
├── .gitignore
└── README.md
```

---

## Development Status

### Completed

* Flutter application architecture
* Onboarding flow
* Authentication
* Supabase integration
* Email verification
* OTP flow
* Password reset
* Home screen
* Application shell
* Bottom navigation
* Plant scanning interface
* Market interface
* Chat interface
* Profile system
* Reusable UI components
* Supabase profile integration
* Plant disease dataset preprocessing
* CNN training pipeline
* EfficientNetB0 disease classification model

### Currently Being Implemented

* CNN model deployment
* FastAPI inference service
* Flutter ↔ ML API integration
* End-to-end disease prediction flow
* RAG pipeline
* Agricultural document processing
* Embedding generation
* Vector database / pgvector integration
* Context-aware agricultural chatbot
* Multimodal chatbot context
* Market analysis pipeline
* XGBoost model
* Multi-model experimentation and comparison
* Selection of the best-performing market prediction model

---

## Future Expansion

After the core system is implemented, KrishiVani can be extended with:

* Larger agricultural knowledge bases
* Additional plant and disease classes
* Improved multimodal reasoning
* Voice-based agricultural assistance
* Personalized recommendations
* Conversation memory
* More sophisticated market forecasting
* Model monitoring and evaluation
* Additional agricultural datasets

---

## Vision

KrishiVani aims to provide farmers with a single intelligent platform that connects **computer vision, machine learning, retrieval-augmented generation, and conversational AI**.

The core workflow is:

**Detect → Understand → Retrieve → Predict → Advise**

Rather than treating disease detection, agricultural knowledge, market analysis, and conversational assistance as isolated features, KrishiVani connects them into one integrated agricultural intelligence system.
