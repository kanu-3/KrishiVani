# KrishiVani

### AI-Powered Agricultural Assistant for Farmers

KrishiVani is an AI-powered agricultural assistance platform designed to help farmers identify plant diseases, understand crop health, access agricultural knowledge, analyze market conditions, and interact with an intelligent agricultural assistant.

The system combines a **Flutter mobile application**, **Supabase backend**, **CNN-based plant disease detection**, **RAG-based agricultural knowledge retrieval**, and **machine learning-based market price forecasting** into a unified platform.

---

## Core Features

### 1. Plant Disease Detection

KrishiVani allows farmers to capture or upload an image of a plant and identify potential diseases using a deep learning model.

The disease detection pipeline uses **EfficientNetB0**, a convolutional neural network architecture trained for multi-class plant disease classification.

The system provides:

- Plant image capture/upload
- Image preprocessing
- CNN-based disease classification
- Disease prediction
- Prediction confidence
- Disease-specific symptoms and recommendations
- Diagnosis history

---

### 2. AI Agricultural Chatbot

The KrishiVani chatbot is **not a generic conversational chatbot**.

It is designed specifically for agricultural assistance and combines multiple sources of context before generating an answer.

The chatbot can use:

- Farmer's text query
- Plant/disease context
- Disease predicted by the CNN model
- Agricultural documents
- Retrieved information from the agricultural knowledge base
- Conversation history

This creates a context-aware agricultural assistant capable of answering questions based on the plant and disease being analyzed.

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

KrishiVani includes a machine-learning-based market price forecasting system.
The V1 system uses historical crop price data to forecast the next 7 days of prices.

The pipeline will involve:

```text
Historical Market Data
        │
        ▼
Data Cleaning & Preprocessing
        │
        ▼
Time-Series Preparation
        │
        ▼
30-Day Historical Window
        │
        ▼
Multi-Output LSTM
        │
        ▼
7-Day Price Forecast
        │
        ▼
Market Analysis
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
| Market Analysis    | LSTM                  |
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
              ┌─────────────────────┼─────────────────────┐
              │                     │                     │
              ▼                     ▼                     ▼
       Supabase Backend      ML Inference API       AI Assistant
       Authentication             FastAPI                 │
       User Profiles                │                     │
       Application Data             │                     │
                                    ▼                     ▼
                             EfficientNetB0         RAG Pipeline
                                    │                     │
                                    ▼                     ▼
                            Disease Prediction      Vector Database
                                                          │
                                                          ▼
                                                 Agricultural Documents
                                                          │
                                                          ▼
                                                    LLM Response

                         Market Analysis
                                │
                                ▼
                         FastAPI / ML API
                                │
                                ▼
                         LSTM Forecasting
                                │
                                ▼
                          7-Day Prediction
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

## Market Forecasting Model

```text
Historical Price Data
        │
        ▼
Data Cleaning
        │
        ▼
Daily Time-Series Construction
        │
        ▼
30-Day Input Window
        │
        ▼
LSTM
        │
        ▼
7-Day Multi-Output Forecast
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

### Application
- Flutter application architecture
- Feature-oriented project structure
- Onboarding flow
- Authentication
- Supabase Auth integration
- Email verification
- OTP flow
- Password reset
- User profile system
- Home screen
- Application shell
- Bottom navigation
- Plant scanning interface
- Diagnosis history
- Chat interface
- Market interface
- Reusable UI components

### Plant Disease Detection
- Plant disease dataset preprocessing
- EfficientNetB0 training
- Multi-class disease classification
- Model evaluation
- CNN inference API
- Flutter ↔ ML API integration
- Disease prediction
- Confidence score
- Diagnosis storage

### Agricultural Assistant
- Agricultural document processing
- Document chunking
- Embedding generation
- PostgreSQL / pgvector integration
- RAG retrieval pipeline
- Context-aware agricultural chatbot
- Disease-aware chatbot context
- Conversation storage

### Market Analysis
- Historical market data processing
- Time-series preprocessing
- Market price forecasting experiment
- XGBoost experimentation
- LSTM forecasting
- 30-day historical input window
- 7-day multi-output prediction
- Forecast visualization
- FastAPI market forecasting endpoint
- Flutter market forecast integration

---

## Future Expansion

After the core system is implemented, KrishiVani can be extended with:

- Continuously updated market datasets
- Automated market-data ingestion
- Dynamic date-aware forecasting
- Automated model retraining
- Model monitoring and evaluation
- More sophisticated time-series forecasting
- Additional crops and agricultural datasets
- Voice-based agricultural assistance
- Improved multimodal reasoning
- Personalized recommendations
- Larger agricultural knowledge bases
- Additional plant and disease classes
- Improved conversational memory

---

## Vision

KrishiVani aims to provide farmers with a single intelligent platform that connects **computer vision, machine learning, retrieval-augmented generation, and conversational AI**.

The core workflow is:

**Detect → Understand → Retrieve → Predict → Advise**

Rather than treating disease detection, agricultural knowledge, market analysis, and conversational assistance as isolated features, KrishiVani connects them into one integrated agricultural intelligence system.

## Author
### Kanishka Jha
B.Tech, AKGEC Ghaziabad 

Flutter + Backend Developer + ML Engineer

Aim: Product AI Engineer

## If you like this project
Consider starring the repo and contributing ideas for sustainability-driven features.
