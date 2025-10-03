## 🖼️ PPU Registers Overview

The PPU exposes eight memory-mapped registers to the CPU, located at addresses $2000 through $2007. Due to incomplete address decoding, these registers are mirrored every 8 bytes from $2008 through $3FFF. For example, a write to $3456 is equivalent to a write to $2006. ([nesdev.org][1])

---

### 1. **PPUCTRL ($2000) – Control Register**

This register controls various aspects of the PPU's operation.

| Bit | Name | Description                                                   |
| --- | ---- | ------------------------------------------------------------- |
| 7   | V    | NMI enable (0: off, 1: on)                                    |
| 6   | P    | PPU master/slave (0: slave, 1: master)                        |
| 5   | H    | Sprite height (0: 8x8, 1: 8x16)                               |
| 4   | B    | Background tile select (0: $0000-$0FFF, 1: $1000-$1FFF)       |
| 3   | S    | Sprite tile select (0: $0000-$0FFF, 1: $1000-$1FFF)           |
| 2   | I    | Increment mode (0: 1, 1: 32)                                  |
| 1-0 | NN   | Nametable select (00: $2000, 01: $2400, 10: $2800, 11: $2C00) |

---

### 2. **PPUMASK ($2001) – Mask Register**

This register controls the PPU's rendering behavior.

| Bit | Name | Description                                          |
| --- | ---- | ---------------------------------------------------- |
| 7   | G    | Greyscale (0: off, 1: on)                            |
| 6   | b    | Background left column (0: off, 1: on)               |
| 5   | M    | Sprite left column (0: off, 1: on)                   |
| 4   | s    | Show sprites (0: off, 1: on)                         |
| 3   | b    | Show background (0: off, 1: on)                      |
| 2   | G    | Show background in leftmost 8 pixels (0: off, 1: on) |
| 1   | s    | Show sprites in leftmost 8 pixels (0: off, 1: on)    |
| 0   | BGR  | Emphasize blue (0: off, 1: on)                       |

---

### 3. **PPUSTATUS ($2002) – Status Register**

This register provides information about the PPU's current state.

| Bit | Name | Description                                                   |
| --- | ---- | ------------------------------------------------------------- |
| 7   | V    | Vertical blank (0: not in vblank, 1: in vblank)               |
| 6   | S    | Sprite 0 hit (0: no hit, 1: hit)                              |
| 5   | O    | Sprite overflow (0: no overflow, 1: overflow)                 |
| 4-0 | -    | Least significant bits previously written into a PPU register |

---

### 4. **OAMADDR ($2003) – OAM Address Register**

This register holds the address for the next OAM read/write operation.

---

### 5. **OAMDATA ($2004) – OAM Data Register**

This register is used to read/write data to/from the OAM.

---

### 6. **PPUSCROLL ($2005) – Scroll Register**

This register sets the fine scroll position.

---

### 7. **PPUADDR ($2006) – Address Register**

This register sets the address for the next PPU read/write operation.

---

### 8. **PPUDATA ($2007) – Data Register**

This register is used to read/write data to/from the PPU.

---

## 🧠 Understanding PPU Memory Access

When accessing PPU memory, the CPU must first set the address using the PPUADDR register. This requires two writes: the first to set the high byte and the second to set the low byte. After setting the address, the CPU can read or write data using the PPUDATA register. It's important to note that each read or write to PPUDATA automatically increments the PPU address, the amount of which is determined by the Increment Mode bit in the PPUCTRL register. ([bugzmanov.github.io][2])

---

## 🗺️ PPU Memory Map

The PPU has a separate 16KB address space, from $0000 to $3FFF, which is divided as follows:

| Address Range | Size | Description            |
| ------------- | ---- | ---------------------- |
| $0000-$0FFF   | 4KB  | Pattern Table 0        |
| $1000-$1FFF   | 4KB  | Pattern Table 1        |
| $2000-$23BF   | 1KB  | Nametable 0            |
| $23C0-$23FF   | 64B  | Attribute Table 0      |
| $2400-$27BF   | 1KB  | Nametable 1            |
| $27C0-$27FF   | 64B  | Attribute Table 1      |
| $2800-$2BBF   | 1KB  | Nametable 2            |
| $2BC0-$2BFF   | 64B  | Attribute Table 2      |
| $2C00-$2FBF   | 1KB  | Nametable 3            |
| $2FC0-$2FFF   | 64B  | Attribute Table 3      |
| $3000-$3EFF   | 3KB  | Unused                 |
| $3F00-$3F1F   | 32B  | Palette RAM            |
| $3F20-$3FFF   | 224B | Mirrors of $3F00-$3F1F |

The PPU uses this memory map to fetch pattern, name table, and attribute table data during rendering. The actual devices that the PPU fetches data from are configured by the cartridge. ([nesdev.org][3])

---

## 🧪 Practical Tips

* **Addressing Mode**: The PPU supports two addressing modes: 1-byte and 32-byte. The mode is set via the Increment Mode bit in the PPUCTRL register.

* **OAM (Object Attribute Memory)**: The PPU has 256 bytes of OAM, used to store sprite data. Each sprite entry is 4 bytes: Y position, tile index, attributes, and X position.

* **Rendering Control**: The PPUMASK register controls various aspects of rendering, including background and sprite visibility, and color emphasis.

* **Status Flags**: The PPUSTATUS register provides flags for vertical blanking, sprite 0 hit, and sprite overflow, which are useful for synchronization and debugging.
