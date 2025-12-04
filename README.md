# 🔥 Fireline

### AI-Powered Penetration Testing CLI

[![License: Proprietary](https://img.shields.io/badge/License-Proprietary-red.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS%20%7C%20Windows-blue.svg)](#supported-platforms)
[![Latest Release](https://img.shields.io/github/v/release/Orizon-eu/fireline)](https://github.com/Orizon-eu/fireline/releases/latest)
[![Status](https://img.shields.io/badge/Status-Alpha%20%7C%20Invite%20Only-orange.svg)](#alpha-access)

**Fireline** is an AI-powered penetration testing assistant developed by **[Orizon](https://orizon.one)**. It provides an intelligent terminal interface where you describe what you want to test, and the AI autonomously executes security tools in isolated containers.

> ⚠️ **AUTHORIZED USE ONLY** - This tool is designed exclusively for authorized security testing with explicit written permission. Unauthorized use is illegal and may result in criminal prosecution.

---

## 💡 How It Works

1. **Chat with AI**: Describe your testing objectives in natural language
2. **AI Plans & Executes**: The AI autonomously runs security tools in Kali Linux containers  
3. **Monitor Progress**: Watch task execution in real-time through the TUI
4. **Review Results**: Get AI analysis of findings and next steps

**No commands to memorize** - just describe what you want to test.

---

## 🚧 Alpha Access - Invite Only

**Fireline is currently in private alpha testing.**

- 🔒 Access is by invitation only
- 📧 To request access, contact: **info@orizon.one**
- ✅ Approved testers will receive a GitHub invitation and API key
- 📚 See [ALPHA_TESTER_GUIDE.md](ALPHA_TESTER_GUIDE.md) after receiving access

---

## 🚀 Quick Installation (Alpha Testers Only)

### Prerequisites

1. **GitHub Access**: You must be invited as a collaborator
2. **Docker or Podman**: Required for security tool execution
3. **Fireline API Key**: Provided with your invitation

### Installation

#### Linux / macOS

```bash
curl -sSL https://raw.githubusercontent.com/Orizon-eu/fireline/main/alpha-install.sh | bash
```

#### Windows (PowerShell as Administrator)

```powershell
# Coming soon
```

**📖 Detailed Instructions**: See [ALPHA_TESTER_GUIDE.md](ALPHA_TESTER_GUIDE.md)

---

## ✨ Key Features

### 🤖 AI-Powered Testing
- Natural language interaction - describe objectives, not commands
- Autonomous tool selection and execution
- Intelligent analysis of findings
- Context-aware suggestions for next steps

### 🐳 Isolated Execution
- All tools run in Kali Linux containers
- Automatic volume mounting for artifacts
- Session persistence across conversations
- No tool installation required on host

### 📊 Interactive TUI
- Split-pane interface: chat + task monitoring
- Real-time task execution status
- Background processing
- Persistent engagement history

### 🛠️ Integrated Tools
- Network scanning (Nmap, Masscan)
- Vulnerability scanning (Nuclei, Nikto)
- Web testing (SQLMap, Gobuster, FFUF)
- Exploitation frameworks (Metasploit)
- Custom tool execution via Bash

---

## 🎯 Example Workflow

```
You: I need to test the web application at https://test.example.com
     I have written authorization. Start with reconnaissance.

Fireline: I'll begin reconnaissance on https://test.example.com. Let me:
          1. Check DNS and subdomain enumeration
          2. Perform port scanning
          3. Identify web technologies
          4. Check for common vulnerabilities
          
          [Task 1] Running subdomain enumeration... ✓
          [Task 2] Port scanning 10.0.1.50... ⟳
          
You: What did you find?

Fireline: I discovered 3 subdomains and 5 open ports:
          - api.test.example.com (port 443)
          - admin.test.example.com (port 8080)
          - staging.test.example.com (port 443)
          
          Would you like me to proceed with vulnerability scanning?

You: Yes, focus on the admin subdomain

Fireline: Running targeted vulnerability scan on admin.test.example.com:8080...
          [Task 3] Nuclei vulnerability scan... ⟳
```

---

## 📦 What's Included

- **Fireline CLI**: Main application binary
- **Auto-configuration**: First-run setup wizard
- **Container Management**: Automatic Kali Linux provisioning
- **Engagement Database**: SQLite-based persistence
- **Legal Compliance**: Built-in authorization reminders

---

## 🔧 Requirements

### System Requirements
- **Docker** or **Podman** (required)
- **4GB RAM minimum** (8GB+ recommended)
- **10GB free disk space**
- **Internet connection** for AI model access

### Account Requirements
- **Fireline API Key** (provided during alpha)
- **GitHub Account** with collaborator access

### Supported Platforms
- ✅ Linux (x86_64, aarch64) - Ubuntu 20.04+, Debian 11+
- ✅ macOS (Intel, Apple Silicon) - macOS 12.0+
- ✅ Windows (x64) - Windows 10/11 with WSL2 + Docker

---

## 🚀 Getting Started

### 1. Install Fireline

Follow the installation instructions above.

### 2. First Run

```bash
fireline
```

On first run, you'll be guided through:
- Legal disclaimer and terms acceptance
- API key configuration
- Workspace setup

### 3. Start Testing

Simply describe what you want to test:

```
> I need to scan 192.168.1.0/24 for open ports and services
> Test this login form for SQL injection: https://lab.example.com/login
> Find subdomains for example.com and check for takeover vulnerabilities
```

The AI handles the rest autonomously.

---

## 📖 Documentation

- **Alpha Tester Guide**: [ALPHA_TESTER_GUIDE.md](ALPHA_TESTER_GUIDE.md)
- **Security Policy**: [SECURITY.md](SECURITY.md)
- **Website**: [orizon.one/fireline](https://orizon.one/fireline)
- **Support**: info@orizon.one
- **Issues**: [GitHub Issues](https://github.com/Orizon-eu/fireline/issues)

---

## 🐛 Reporting Issues

As an alpha tester, your feedback is crucial:

1. **Check Existing Issues**: Avoid duplicates
2. **Use Issue Templates**: Bug report, feature request, or tool request
3. **Be Detailed**: Include logs, screenshots, steps to reproduce
4. **Tag Appropriately**: Use `alpha`, `bug`, `enhancement` labels

**Priority Support**: Alpha testers get responses within 24 hours.

---

## 🔒 Security & Legal

### Authorization Requirements

**YOU MUST:**
- ✅ Obtain explicit **written authorization** before testing
- ✅ Define clear **scope boundaries**
- ✅ Comply with **GDPR, CCPA**, and applicable regulations
- ✅ Maintain **comprehensive activity logs**

### Criminal Penalties

Unauthorized access is a **criminal offense** under:
- 🇺🇸 Computer Fraud and Abuse Act (CFAA) - 18 U.S.C. § 1030
- 🇬🇧 Computer Misuse Act 1990
- 🇪🇺 EU Directive 2013/40/EU
- 🌍 Similar laws worldwide

**By using Fireline, you acknowledge full understanding and acceptance of these terms.**

---

## 📝 License

**Proprietary Software** - See [LICENSE](LICENSE) for full terms.

This is proprietary software owned by Orizon. All rights reserved.

---

## 🌟 About Orizon

**Fireline** is developed by **[Orizon](https://orizon.one)** - a cybersecurity company specializing in AI-powered security solutions.

### Contact

- **General Inquiries**: info@orizon.one
- **Website**: https://orizon.one

---

## 🙏 Alpha Testers

Thank you to our alpha testers for their valuable feedback and contributions.

---

**⚠️ ALPHA SOFTWARE DISCLAIMER**

This is alpha software under active development. Features may change without notice. Use only in isolated lab environments with explicit authorization.

---

**Made with ❤️ by the Orizon Security Team**
