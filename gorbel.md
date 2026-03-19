## Gorbel G-Force Q2 / iQ2 — Intelligent Lifting Device (ILD)

**Source:** [Gorbel official](https://www.gorbel.com/products/ergonomic-lifting/g-force-servo-powered-intelligent-assist-device), [Acculift](https://acculift.com/gorbel-debuts-g-force-iq2-and-q2-with-impressive-new-features/), [ManualsLib service manual](https://www.manualslib.com/manual/2233092/Gorbel-G-Force-Q2-Series.html)

---

### Mechanical Specifications

| Parameter | Value |
|---|---|
| Capacity range | 165 lbs to 1,320 lbs |
| Travel speed (max) | 200 ft/min |
| Lifting medium | Wire rope (Gorbel-supplied only — 3rd party voids warranty) |
| Limit switches | Mechanical upper + lower; lower ensures minimum 2 full wire rope wraps on drum |

---

### Control Architecture (Tech Stack)

#### Actuation Layer
An industrial processor-controlled servo drive system delivers the lifting precision and speed. The core loop is force-sensing → processor → servo drive → motor.

#### Sensing / Input
The grip on the handle is connected to a force sensing device so that when the user applies force up or down along the central axis, this is interpreted as intent to move. Force-sensing handles (FSH) are distinct from slide handles — FSH detects force without physical displacement.

#### Operating Modes
- **Standard:** Force-proportional velocity command.
- **Float (zero-gravity):** With a mere ½ lb (227 g) of force on the load itself, operators can precisely orient loads throughout the full stroke range.
- **Auto Float (Q2/iQ2):** A seamless transition mode that does not require the operator to press a button to engage float mode.

#### Safety Hardware
- Mechanical upper/lower limit switches
- Slack switch (detects wire rope slack → stops downward motion)
- Anti-drop overload detection
- Anti-recoil: Protects against a dropped weight while running Float Mode, which would cause the unit to speed upward until hitting an object.
- Service Mode: activatable via handle when peripheral controls are damaged

#### I/O and Communication

| Feature | Q2 | iQ2 |
|---|---|---|
| Handle I/O | 2 inputs / 2 outputs | 8 configurable I/O points on handle |
| Actuator I/O | Basic | Dedicated input/output points at the actuator |
| Comms port | Communications connector is the communications port for the G-Force (wired RJ45/Cat5 Ethernet) | Same + wireless AP |

**Networking:** Service and configuration use a laptop with WiFi connectivity or RJ45 port and Cat5 Ethernet cable; the unit exposes a fixed IP (192.168.105.26) accessed via VNC Viewer. Gorbel recommends B&R VNC Viewer.

The internal controller is B&R Automation platform (evidenced by B&R VNC Viewer requirement and the B&R servo drive ecosystem). Gorbel does not publicly disclose the exact PLC/drive part numbers.

#### HMI
A crisp OLED higher-resolution handle display is easier to read and supports multiple languages. Handle and PC/tablet Smart Connect user interfaces are available in English, French, German, Italian, and Spanish.

---

### Electrical

| Parameter | Value |
|---|---|
| Power | Standard industrial 3-phase (US: 208–240V, 460V depending on capacity) |
| CE certified | Yes (when wired to manufacturer-specified voltage) |
| Patents | US 5,865,426 / 6,622,990 / 6,386,513 / 6,886,812 |

---

### Known Tech Stack Summary

| Layer | Technology |
|---|---|
| Motor | Servo motor (AC servo, manufacturer not disclosed publicly) |
| Drive | Industrial servo drive (B&R Automation ecosystem, inferred from tooling) |
| Controller | Industrial processor (B&R PLC, inferred) |
| Sensing | Force-sensing transducer on handle grip |
| Position feedback | Encoder on drum/motor (standard for servo; exact type not disclosed) |
| HMI display | OLED (handle); VNC-based visualization (PC/tablet) |
| Configuration interface | VNC over TCP/IP (wired Cat5 or WiFi AP) |
| I/O integration | Digital I/O on handle + actuator (iQ2: 8 configurable handle points) |
| Fieldbus | Not publicly disclosed; EtherNet/IP or proprietary not confirmed in public docs |

