# 🧪 Fireline Alpha Tester Guide

Welcome to the Fireline alpha program! This guide will help you get started with the AI-powered penetration testing assistant.

---

## 🎯 What is Fireline?

Fireline is an AI-powered CLI where you **describe what you want to test** in natural language, and the AI **autonomously executes security tools** in isolated Kali Linux containers.

**Key Differences from Traditional Tools:**
- ❌ No commands to memorize
- ❌ No manual tool chaining  
- ✅ Natural conversation with AI
- ✅ Autonomous tool selection and execution
- ✅ Real-time task monitoring in TUI

---

## 📋 Prerequisites

Before you begin:

- [ ] **GitHub Account** with collaborator access to `Orizon-eu/fireline`
- [ ] **Docker** or **Podman** installed and running
- [ ] **Fireline API Key** (provided in invitation email)
- [ ] **System**: 4GB+ RAM, 10GB disk space

---

## 🚀 Installation

### Step 1: Verify GitHub Access

```bash
gh auth login  # If not authenticated
gh repo view Orizon-eu/fireline
```

**Expected**: Repository details  
**If error**: Contact info@orizon.one

### Step 2: Install Fireline

#### Linux / macOS (Quick Install)

```bash
curl -sSL https://raw.githubusercontent.com/Orizon-eu/fireline/main/alpha-install.sh | bash
```

#### Manual Installation

```bash
# List releases
gh release list --repo Orizon-eu/fireline

# Download for your platform
gh release download v0.1.0-alpha --repo Orizon-eu/fireline --pattern '*darwin-aarch64.tar.gz*'

# Extract and install
tar -xzf fireline-*.tar.gz
sudo mv fireline /usr/local/bin/
chmod +x /usr/local/bin/fireline
```

### Step 3: Verify Installation

```bash
fireline --version
```

---

## 🔑 First Run Setup

### Launch Fireline

```bash
fireline
```

### What Happens on First Run:

1. **Legal Disclaimer**: Read and accept terms (required)
2. **API Key Setup**: Choose from menu:
   - **[1] I have a Fireline API key** - Enter your key
   - **[2] Request a Fireline API key** - Opens registration
   - **[3] Exit** - Exit setup
3. **Workspace Initialization**: Creates `.fireline/` directory

### API Key Configuration

Your API key is stored securely in `~/.fireline/.env`:

```bash
FIRELINE_API_KEY=fl_alpha_xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

To update later:
```bash
nano ~/.fireline/.env
```

---

## 💬 Using Fireline

### The Interface

Fireline uses a **split-pane TUI**:
- **Left**: Chat with AI
- **Right**: Task execution monitoring

### How to Interact

Just **describe what you want to test** in natural language:

```
> I need to scan 192.168.1.100 for open ports and identify services
```

The AI will:
1. Understand your objective
2. Select appropriate tools (e.g., Nmap)
3. Execute in Kali container
4. Show results
5. Suggest next steps

### Example Conversations

#### Reconnaissance

```
You: I have authorization to test network 10.0.0.0/24. 
     Start with host discovery and service enumeration.

Fireline: I'll perform reconnaissance on 10.0.0.0/24:
          1. Host discovery (ping sweep)
          2. Port scanning on live hosts
          3. Service version detection
          
          [Task 1] Host discovery... ✓ (15 hosts found)
          [Task 2] Port scanning... ⟳
```

#### Web Application Testing

```
You: Test https://lab.example.com for common web vulnerabilities.
     I have written authorization.

Fireline: I'll test https://lab.example.com for vulnerabilities:
          1. Technology fingerprinting
          2. Directory enumeration
          3. Nuclei vulnerability scan
          4. SQL injection testing
          
          [Task 1] Running whatweb... ✓
          [Task 2] Gobuster directory scan... ⟳
```

#### Exploitation

```
You: The previous scan found an SQLi in the login form.
     Can you exploit it to extract database names?

Fireline: I'll use SQLMap to exploit the SQL injection:
          [Task 5] Running SQLMap with --dbs flag... ⟳
```

### AI Capabilities

The AI can:
- ✅ Select appropriate tools automatically
- ✅ Chain multiple tools together
- ✅ Analyze results and suggest next steps
- ✅ Remember context from earlier conversation
- ✅ Execute custom Bash commands
- ✅ Handle errors and retry with different approaches

---

## 🎮 Advanced Usage

### Command Line Options

```bash
# Verbose logging
fireline --verbose

# Skip Docker check (use local tools)
fireline --skip-docker-check

# Load specific engagement
fireline --engagement "Client XYZ Pentest"

# Simple REPL mode (no TUI)
fireline --no-tui

# Non-interactive with prompt
fireline --prompt "scan 192.168.1.1" --non-interactive
```

### Engagement Management

Fireline automatically tracks your testing sessions. To reference past work:

```
> Load my last engagement with example.com
> Show findings from yesterday's scan
> Export results from the API pentest engagement
```

### Background Tasks

Tasks run in the background. You can:
- Continue chatting while tools execute
- Monitor progress in the right pane
- Reference task results later

---

## 📊 What to Test (Alpha Focus)

### Critical Features

- [ ] Natural language understanding
- [ ] Tool selection accuracy
- [ ] Container isolation
- [ ] Task monitoring
- [ ] Result analysis quality
- [ ] Engagement persistence

### User Experience

- [ ] First-run setup flow
- [ ] API key configuration
- [ ] TUI responsiveness
- [ ] Error handling
- [ ] Legal disclaimer clarity

### Tool Integration

- [ ] Nmap scanning
- [ ] Nuclei vulnerability detection
- [ ] SQLMap exploitation
- [ ] Gobuster directory enumeration
- [ ] Custom Bash commands

---

## 🐛 Reporting Issues

### What to Report

- ✅ AI misunderstanding requests
- ✅ Tool execution failures
- ✅ TUI rendering issues
- ✅ Container problems
- ✅ Unexpected behavior

### How to Report

1. **GitHub Issues**: https://github.com/Orizon-eu/fireline/issues
2. **Include**:
   ```bash
   # System info
   fireline --version
   uname -a
   docker --version
   
   # Logs
   cat ~/.fireline/logs/fireline.log
   ```
3. **Describe**: What you asked, what happened, what you expected

### Priority Support

Alpha testers get **responses within 24 hours** for critical issues.

---

## 💡 Best Practices

### Testing Environment

**⚠️ ALWAYS test in isolated lab environments**

- Use virtual machines or containers as targets
- Never test production systems
- Maintain written authorization documents
- Keep detailed test logs

### Effective Prompts

**Good prompts are specific:**

✅ "Scan 192.168.1.100 for web services and test for SQL injection"  
❌ "Check this server"

✅ "Enumerate subdomains for example.com using passive methods"  
❌ "Find stuff about example.com"

### Authorization

Before every engagement:
- Obtain explicit written authorization
- Define scope boundaries clearly
- Document all activities
- Report findings responsibly

---

## 🔧 Troubleshooting

### Docker Not Available

```
Error: Docker is not running
```

**Fix**: Start Docker/Podman
```bash
# Linux
sudo systemctl start docker

# macOS
open -a Docker

# Then rerun
fireline
```

### API Key Issues

```
Error: Invalid API key
```

**Fix**: Update your key
```bash
nano ~/.fireline/.env
# Update FIRELINE_API_KEY=your_key_here
```

### Container Errors

```
Error: Failed to create container session
```

**Fix**: Pull the image manually
```bash
docker pull eagleb/fireline:latest
fireline
```

---

## 📞 Support

### Primary Contact
- **Email**: info@orizon.one
- **Response Time**: Within 24 hours
- **For**: Bugs, installation help, API keys

### GitHub Issues
- **URL**: https://github.com/Orizon-eu/fireline/issues
- **For**: Bug reports, feature requests

---

## 🎁 Alpha Benefits

### During Alpha
- ✅ Free API usage
- ✅ Priority support
- ✅ Direct feature influence
- ✅ Early access to updates

### After Alpha
- ✅ 50% off first 3 months
- ✅ Recognition in release notes
- ✅ Lifetime "Founding Tester" status

---

## 🔄 Updating Fireline

Check for updates:

```bash
# List releases
gh release list --repo Orizon-eu/fireline --limit 5

# Download latest
curl -sSL https://raw.githubusercontent.com/Orizon-eu/fireline/main/alpha-install.sh | bash
```

---

## ❓ FAQ

**Q: How does Fireline choose which tools to use?**  
A: The AI analyzes your request and selects tools based on the objective, target type, and context from the conversation.

**Q: Can I use custom tools?**  
A: Yes! Just ask the AI to run custom Bash commands. They execute in the Kali container with all standard tools available.

**Q: Is data encrypted?**  
A: Yes. All API communication uses TLS 1.3. Local data is stored in SQLite database on your machine.

**Q: Can I share Fireline?**  
A: No, access is per-person. Colleagues should request access at info@orizon.one

**Q: What if I find a security vulnerability?**  
A: Report immediately to info@orizon.one. Do not disclose publicly.

**Q: Can I use Fireline commercially?**  
A: During alpha, only for testing. Commercial licensing available in beta.

---

## 🙏 Thank You!

Your feedback shapes Fireline's development. Thank you for being an alpha tester!

**Questions?** info@orizon.one

---

**Happy Testing! 🔥**

*Orizon Security Team*
