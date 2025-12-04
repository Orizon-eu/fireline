# 🔥 Fireline

**AI-Powered Penetration Testing CLI**

Fireline is an intelligent security testing tool that combines AI reasoning with professional pentesting tools.

> ⚠️ **For authorized security testing only** - Requires explicit written permission.

---

## 🚀 Quick Install

### Linux / macOS

```bash
curl -sSL https://github.com/Orizon-eu/fireline/releases/latest/download/install.sh | bash
```

### Windows (PowerShell as Administrator)

```powershell
irm https://github.com/Orizon-eu/fireline/releases/latest/download/install.ps1 | iex
```

---

## 🔑 Get Your API Key

Visit **[orizon.one/fireline](https://orizon.one/fireline)** to obtain your API key.

---

## ⚙️ Setup

After installation, run Fireline and follow the setup wizard:

```bash
fireline
```

You'll be prompted to enter your API key on first run.

---

## 📦 Manual Installation

Download pre-built binaries from the [latest release](https://github.com/Orizon-eu/fireline/releases/latest):

| Platform | Architecture | Download |
|----------|-------------|----------|
| Linux | x86_64 | [fireline-*-linux-x86_64.tar.gz](https://github.com/Orizon-eu/fireline/releases/latest) |
| Linux | ARM64 | [fireline-*-linux-aarch64.tar.gz](https://github.com/Orizon-eu/fireline/releases/latest) |
| macOS | Intel | [fireline-*-darwin-x86_64.tar.gz](https://github.com/Orizon-eu/fireline/releases/latest) |
| macOS | Apple Silicon | [fireline-*-darwin-aarch64.tar.gz](https://github.com/Orizon-eu/fireline/releases/latest) |
| Windows | x64 | [fireline-*-windows-x86_64.zip](https://github.com/Orizon-eu/fireline/releases/latest) |

### Extract and Install

**Linux/macOS:**
```bash
tar -xzf fireline-*.tar.gz
sudo mv fireline /usr/local/bin/
chmod +x /usr/local/bin/fireline
```

**Windows:**
```powershell
Expand-Archive fireline-*.zip
Move-Item fireline.exe C:\Windows\System32\
```

---

## 📋 Requirements

- **Docker** or **Podman** (for security tools)
- **Fireline API Key** from [orizon.one/fireline](https://orizon.one/fireline)

---

## 💬 Support

- **Website**: [orizon.one](https://orizon.one)
- **Email**: info@orizon.one

---

## 📝 License

MIT License - See [LICENSE](LICENSE) file.

---

**⚠️ Legal Notice**

This tool is for **authorized security testing only**. Unauthorized access to computer systems is illegal. Users are responsible for obtaining proper authorization and complying with all applicable laws.

**Developed by [Orizon](https://orizon.one)**
