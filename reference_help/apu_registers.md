### 🎵 NES APU Registers Overview

The APU is responsible for sound generation and consists of four main channels:

1. **Two Square Wave Channels** – Registers `$4000-$4003` and `$4004-$4007`
2. **Triangle Wave Channel** – Registers `$4008-$400B`
3. **Noise Channel** – Registers `$400C-$400F`
4. **DMC (Delta Modulation Channel)** – Registers `$4010-$4013`

Additionally, there are control and status registers:

* **Control Register**: `$4015` – Enables or disables the channels.
* **Status Register**: `$4015` (read) – Provides the status of the channels.
* **Frame Counter**: `$4017` – Controls the timing of the APU's frame sequencer.

---

### 🧾 Detailed Register Breakdown

#### Square Wave Channels (`$4000-$4003`, `$4004-$4007`)

* **`$4000` / `$4004`**: Duty cycle and volume control.
* **`$4001` / `$4005`**: Sweep unit settings.
* **`$4002` / `$4006`**: Period low byte.
* **`$4003` / `$4007`**: Period high byte and counter reload.

#### Triangle Wave Channel (`$4008-$400B`)

* **`$4008`**: Linear counter control.
* **`$400A`**: Period low byte.
* **`$400B`**: Period high byte.

#### Noise Channel (`$400C-$400F`)

* **`$400C`**: Noise control.
* **`$400E`**: Period low byte.
* **`$400F`**: Period high byte.

#### DMC Channel (`$4010-$4013`)

* **`$4010`**: Frequency control.
* **`$4011`**: Loop and IRQ control.
* **`$4012`**: Sample address.
* **`$4013`**: Sample length.

#### Control and Status Registers

* **`$4015` (write)**: Enables or disables channels.
* **`$4015` (read)**: Returns the status of channels.
* **`$4017`**: Frame counter control.

---

### 🛠️ Example: Initializing a Square Wave Channel

To initialize a square wave channel with a specific frequency and volume:

```assembly
; Set frequency to 440 Hz (approx. A4 note)
lda #$FF
sta $4002
lda #$F0
sta $4003

; Set volume to 15 (maximum)
lda #$0F
sta $4000

; Set duty cycle to 50%
lda #$30
sta $4000
```

This code sets the frequency and volume for one of the square wave channels.

