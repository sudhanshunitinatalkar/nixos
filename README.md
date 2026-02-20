# NixOS Configuration
# To enable conservation mode (write '1' to the file)
echo 1 | sudo tee /sys/bus/platform/devices/VPC2004:00/conservation_mode

# To disable it
echo 0 | sudo tee /sys/bus/platform/devices/VPC2004:00/conservation_mode

# github ssh key command
ssh-keygen -t ed25519 -C "atalkarsudhanshu@proton.me"



Here is the complete list of AT commands to diagnose your GSM modem. Run these in `minicom` one by one.

**To start Minicom:**

```bash
sudo minicom -D /dev/ttyAMA0 -b 115200

```

### 1. The "Pulse Check" (Basic Connectivity)

* **`AT`**
* **Response:** `OK`
* **Meaning:** The modem is alive and listening. If you don't get `OK`, stop here; your UART wiring or overlay is broken.


* **`ATE1`**
* **Response:** `OK`
* **Meaning:** Turns on "Echo" so you can see what you are typing.



### 2. SIM Card Status

* **`AT+CPIN?`**
* **Response:** `+CPIN: READY`
* **Meaning:** SIM is inserted and unlocked.
* *Error:* `+CME ERROR: SIM not inserted` means check your physical SIM card slot.


* **`AT+CCID`**
* **Response:** (Long string of numbers)
* **Meaning:** Reads the unique ID of the SIM card (confirms the chip is readable).



### 3. Signal Strength

* **`AT+CSQ`**
* **Response:** `+CSQ: <rssi>,<ber>` (e.g., `+CSQ: 20,99`)
* **Meaning:**
* **0-9:** Marginal/Weak (might drop connections).
* **10-19:** Good.
* **20-31:** Excellent.
* **99:** No Signal / Unknown.





### 4. Network Registration (Are we connected to a tower?)

* **`AT+CREG?`** (Legacy 2G/Voice)
* **Response:** `+CREG: 0,1` or `0,5`


* **`AT+CEREG?`** (LTE/4G - **Critical for Jio**)
* **Response:** `+CEREG: 0,1` or `0,5`
* **Meaning:**
* `0,0`: Not searching.
* `0,1`: Registered, Home network (Good).
* `0,2`: Searching...
* `0,3`: Registration denied (Check SIM plan).
* `0,5`: Roaming (Good).





### 5. Operator Selection

* **`AT+COPS?`**
* **Response:** `+COPS: 0,0,"Jio 4G",7` (or similar)
* **Meaning:** Tells you exactly which carrier you are connected to. The number `7` at the end means LTE (4G).



### 6. Internet / APN Configuration

* **`AT+CGATT?`**
* **Response:** `+CGATT: 1`
* **Meaning:** Attached to GPRS/Packet Service. `1` is good. `0` means disconnected.


* **`AT+CGDCONT?`**
* **Response:** `+CGDCONT: 1,"IP","jionet",...`
* **Meaning:** Checks your APN settings.
* *Action:* If it is empty or wrong, set it: `AT+CGDCONT=1,"IP","jionet"`



### 7. Modem Information

* **`AT+CGMI`** -> Manufacturer (e.g., SIMCOM)
* **`AT+CGMM`** -> Model (e.g., A7670C)
* **`AT+CGSN`** -> IMEI Number

### 8. Hard Reset (If stuck)

* **`AT+CFUN=1,1`**
* **Action:** Resets the modem firmware immediately (like rebooting the chip).



---

### **Troubleshooting Checklist**

1. **No `OK` on `AT`?** -> Linux hasn't loaded the overlay. Run `ls -l /dev/ttyAMA0` to check if the file exists.
2. **`+CSQ: 99,99`?** -> Antenna is disconnected or broken.
3. **`+CEREG: 0,2` forever?** -> SIM is not activated or APN is missing.



sudo pppd /dev/ttyAMA0 115200 \
    debug \
    nodetach \
    noauth \
    user "jio" \
    defaultroute \
    replacedefaultroute \
    noipv6 \
    usepeerdns \
    nocrtscts \
    lcp-echo-failure 4 \
    lcp-echo-interval 30 \
    connect 'chat -v -t 15 ABORT BUSY ABORT "NO CARRIER" ABORT ERROR "" AT OK-AT-OK "AT+CGDCONT=1,\"IP\",\"jionet\"" OK ATD*99# CONNECT'



curl -X POST http://127.0.0.1:18789/api/chat \
     -H "Authorization: Bearer sudhanshu" \
     -H "Content-Type: application/json" \
     -d '{"message": "Is the Granite model active?", "user_id": "sudha"}'