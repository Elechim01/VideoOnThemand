#  VideoOnTheMand (Apple TV)

**VideoOnTheMand** è l'estensione per tvOS del sistema Gestionale Video. Progettata specificamente per l'esperienza "big screen", l'app permette la fruizione fluida dei contenuti video presenti nel cloud attraverso un'interfaccia nativa, veloce e ottimizzata per il Siri Remote.

---

## 🚀 Caratteristiche Principali

### 📺 Streaming Video su Apple TV
* **Player Nativo**: Integrazione completa con `AVPlayer` per il supporto di streaming HLS e file MP4 ad alta risoluzione.
* **Ottimizzazione tvOS**: Interfaccia focalizzata sul contenuto, con supporto per la navigazione tramite il focus system di Apple TV.
* **Qualità Adattiva**: Gestione automatica della qualità video in base alla connessione di rete dell'utente.

### 🕒 Cronologia dei Video
* **Riprendi la Visione**: Sistema di tracciamento dei progressi che permette di riprendere un video esattamente da dove era stato interrotto.
* **Visti di Recente**: Sezione dedicata nella Home per accedere rapidamente agli ultimi contenuti visualizzati.
* **Sincronizzazione**: La cronologia è salvata su Firestore e sincronizzata tra tutti i tuoi dispositivi (iOS/macOS).

### 📊 Informazioni sullo Spazio
* **Dashboard Storage**: Visualizzazione chiara dello spazio totale occupato dalla tua libreria video direttamente sulla TV.
* **Statistiche Cloud**: Monitoraggio delle quote di Firebase Storage per avere sempre sotto controllo il limite del proprio piano.

---

## 🏗 Architettura & Moduli

L'app Apple TV sfrutta il sistema modulare già collaudato:

1. **[ElechimCore](https://github.com/Elechim01/ElechimCore)**: Gestione delle utility, logica dei tempi di visione e logger.
2. **[Services](https://github.com/Elechim01/Services)**: Interazione con Firebase Auth per il profilo utente e Firestore per i metadati dei video.

---

## 💻 Requisiti Tecnici
* **Piattaforma**: tvOS 17.0+ (consigliata 18.0)
* **Linguaggio**: Swift 6.0
* **Framework**: SwiftUI (tvOS), AVKit, Firebase

---

## 🛠 Setup Rapido

1. **Clona il repository**:
   ```bash
   git clone [https://github.com/Elechim01/VideoOnThemand.git](https://github.com/Elechim01/VideoOnThemand.git)
