# ALU_4Bit

This is an implementatio of a 4-bit ALU in VHDL .

---

### Inputs

| Name     | Purpose                    | Size           |
|----------|----------------------------|----------------|
| A, B     | Operands                   | 4-bit unsigned |
| selector | Operation code             | 4-bit          |
| cin      | Carry-in                   | 1 bit          |
| clk      | Clock signal               | 1 bit          |
| ce       | Clock enable (active-high) | 1 bit          |

---

### Outputs

| Name  | Purpose     | Size           |
|-------|-------------|----------------|
| cout  | Carry flag  | 1 bit          |
| sign  | Sign flag   | 1 bit          |
| zero  | Zero flag   | 1 bit          |
| F     | Result      | 4-bit unsigned |

---

### Operations

| Code | Operation           |
|------|---------------------|
| 0000 | A + B               |
| 0001 | A - B               |
| 0010 | B - A               |
| 0011 | Increment A         |
| 0100 | Increment B         |
| 0101 | Two's Complement A  |
| 0110 | Two's Complement B  |
| 0111 | A XOR B             |
| 1000 | A OR B              |
| 1001 | A AND B             |
| 1010 | One's Complement A  |
| 1011 | One's Complement B  |
| 1100 | Rotate Left A       |
| 1101 | Rotate Left B       |
| 1110 | Pass A              |
| 1111 | Pass B              |
