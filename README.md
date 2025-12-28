# OpenRGB Systemd Service

systemd configuration files to automatically run OpenRGB with a fixed color at system boot and when resuming from sleep.

## Files

- `openrgb-default.service` - Systemd service file that runs OpenRGB at boot
- `openrgb-resume.sh` - Script that runs OpenRGB when the system resumes from sleep

## Installation

### 1. Copy the service file

Copy the systemd service file to the system directory:

```bash
sudo cp openrgb-default.service /etc/systemd/system/
```

### 2. Copy the resume script

Copy the sleep/resume hook script to the systemd sleep directory:

```bash
sudo cp openrgb-resume.sh /usr/lib/systemd/system-sleep/
```

The script should already be executable, but if needed, make it executable:

```bash
sudo chmod +x /usr/lib/systemd/system-sleep/openrgb-resume.sh
```

### 3. Reload systemd daemon

Reload systemd to recognize the new service:

```bash
sudo systemctl daemon-reload
```

### 4. Enable and start the service

Enable the service to start at boot:

```bash
sudo systemctl enable openrgb-default.service
```

Start the service immediately (optional):

```bash
sudo systemctl start openrgb-default.service
```

### 5. Verify the service status

Check that the service is running:

```bash
sudo systemctl status openrgb-default.service
```
