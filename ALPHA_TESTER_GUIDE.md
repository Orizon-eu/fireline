# 🧪 Fireline Alpha Tester Guide

Welcome to the Fireline alpha program! This guide will help you get started.

---

## 🎯 What is Alpha Testing?

You're among the first to test Fireline's AI-powered penetration testing capabilities. Your feedback will shape the final product.

**As an alpha tester, you'll:**
- Test cutting-edge AI pentesting features
- Report bugs and suggest improvements
- Help refine the user experience
- Get free API usage during alpha
- Be recognized as an alpha contributor

---

## 📋 Prerequisites

Before you begin, ensure you have:

- [ ] **GitHub Account** with collaborator access to `Orizon-eu/fireline`
- [ ] **GitHub CLI** (`gh`) installed and authenticated
- [ ] **Docker** or **Podman** installed
- [ ] **Fireline API Key** (provided in your invitation email)
- [ ] **System Requirements**: 4GB+ RAM, 10GB disk space

---

## 🚀 Installation Steps

### Step 1: Verify GitHub Access

Check that you have access to the private repository:

```bash
gh auth login  # If not already authenticated
gh repo view Orizon-eu/fireline
```

**Expected output**: Repository details
**If error**: Contact info@orizon.one

### Step 2: Install GitHub CLI (if needed)

#### macOS
```bash
brew install gh
```

#### Linux (Debian/Ubuntu)
```bash
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
  sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
  sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt update && sudo apt install gh
```

#### Windows
```powershell
# PowerShell
winget install --id GitHub.cli

# Or download from: https://cli.github.com/
```

### Step 3: Download Fireline

#### Option A: Quick Install (Linux/macOS)

```bash
# Download and run the alpha install script
gh release download --repo Orizon-eu/fireline --pattern 'alpha-install.sh'
chmod +x alpha-install.sh
./alpha-install.sh
```

#### Option B: Manual Download

```bash
# List available releases
gh release list --repo Orizon-eu/fireline

# Download for your platform
# Linux x86_64
gh release download v0.1.0-alpha --repo Orizon-eu/fireline --pattern '*linux-x86_64.tar.gz*'

# macOS Intel
gh release download v0.1.0-alpha --repo Orizon-eu/fireline --pattern '*darwin-x86_64.tar.gz*'

# macOS Apple Silicon
gh release download v0.1.0-alpha --repo Orizon-eu/fireline --pattern '*darwin-aarch64.tar.gz*'

# Extract and install
tar -xzf fireline-*-*.tar.gz
sudo mv fireline /usr/local/bin/
chmod +x /usr/local/bin/fireline
```

#### Option C: Windows

```powershell
# Download installer
gh release download --repo Orizon-eu/fireline --pattern 'install.ps1'
.\install.ps1
```

### Step 4: Verify Installation

```bash
fireline --version
```

**Expected**: Version number (e.g., `Fireline v0.1.0-alpha`)

---

## 🔑 Configuration

### Setup Your API Key

Your Fireline API key was provided in your invitation email.

#### Automatic Setup (First Run)

```bash
fireline
# You'll be prompted to enter your API key
```

#### Manual Setup

```bash
# Create config directory
mkdir -p ~/.fireline

# Create config file
cat > ~/.fireline/.env << 'EOF'
FIRELINE_API_KEY=fl_alpha_xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
FIRELINE_MODEL=fireline-assault
FIRELINE_ENDPOINT=https://api.orizon.one/v1
EOF

# Secure the config file
chmod 600 ~/.fireline/.env
```

### Verify Configuration

```bash
fireline --check-config
```

---

## 🎮 Getting Started

### Your First Engagement

```bash
# Start Fireline
fireline

# Create a new engagement
> new engagement "Test Lab - Alpha Testing"

# Example reconnaissance
> scan host 192.168.1.100

# Get AI assistance
> analyze findings

# Exit
> exit
```

### Interactive Commands

Fireline uses natural language commands. Examples:

```bash
# Reconnaissance
> scan network 192.168.1.0/24
> enumerate subdomains example.com
> check dns example.com

# Scanning
> run nmap on 192.168.1.100
> scan for vulnerabilities
> check for open ports

# Analysis
> what are the critical findings?
> suggest next steps
> prioritize vulnerabilities

# Exploitation (with authorization!)
> test sql injection on http://lab.example.com/login
> attempt privilege escalation

# Reporting
> generate report
> export findings
> show statistics
```

---

## 📊 What to Test

As an alpha tester, please focus on:

### Critical Features
- [ ] AI reasoning and decision-making
- [ ] Tool integration (Nmap, Nuclei, etc.)
- [ ] Natural language command parsing
- [ ] Finding analysis and prioritization
- [ ] Report generation

### User Experience
- [ ] Installation process
- [ ] First-run experience
- [ ] Command clarity and responsiveness
- [ ] Error messages and help
- [ ] Documentation clarity

### Edge Cases
- [ ] Invalid inputs
- [ ] Network timeouts
- [ ] Large scan results
- [ ] Concurrent operations
- [ ] Resource limits

---

## 🐛 Reporting Issues

Your feedback is invaluable! Please report:

### What to Report
- ✅ Bugs and errors
- ✅ Confusing behavior
- ✅ Feature requests
- ✅ Documentation gaps
- ✅ Performance issues

### How to Report

1. **Check Existing Issues**: https://github.com/Orizon-eu/fireline/issues

2. **Create New Issue**: Use our templates
   - Bug Report
   - Feature Request
   - Tool Integration Request

3. **Include Details**:
   ```bash
   # System info
   fireline --version
   uname -a
   docker --version

   # Relevant logs
   cat ~/.fireline/logs/fireline.log
   ```

4. **Add Labels**: `alpha`, `bug`, `enhancement`, etc.

### Priority Response

Alpha testers get **priority support within 24 hours** for critical issues.

---

## 💡 Best Practices

### Testing Environment

**⚠️ ALWAYS test in isolated lab environments**

- Use virtual machines or containers
- Never test on production systems
- Maintain clear documentation of test targets
- Have written authorization for all testing

### Responsible Testing

Even in alpha, follow security best practices:
- Obtain explicit authorization
- Define clear scope
- Document all actions
- Report findings responsibly
- Respect rate limits

### Feedback Guidelines

When providing feedback:
- Be specific and detailed
- Include steps to reproduce
- Suggest improvements
- Compare with other tools (if relevant)
- Focus on user experience

---

## 📞 Support Channels

### Primary Support
- **Email**: info@orizon.one
- **Response Time**: Within 24 hours
- **For**: Bugs, installation issues, API key problems

### GitHub Issues
- **URL**: https://github.com/Orizon-eu/fireline/issues
- **For**: Bug reports, feature requests, public discussions

### Emergency Contact
- **Critical bugs**: info@orizon.one
- **Examples**: Data loss, security vulnerabilities, system crashes

---

## 🎁 Alpha Tester Benefits

### During Alpha
- ✅ Free API usage (no billing)
- ✅ Priority support
- ✅ Direct influence on features
- ✅ Early access to new capabilities
- ✅ Alpha tester badge (coming soon)

### After Alpha
- ✅ Discounted pricing (50% off first 3 months)
- ✅ Recognition in release notes
- ✅ Special contributor badge
- ✅ Lifetime "Founding Tester" status

---

## 📅 Alpha Timeline

- **Current Phase**: Alpha 1 (Core Features)
- **Duration**: 6-8 weeks
- **Next Phase**: Alpha 2 (Advanced Features)
- **Beta Target**: Q1 2025

### What's Coming
- Enhanced AI models
- More tool integrations
- Team collaboration features
- Advanced reporting
- API for custom integrations

---

## 🔄 Updating Fireline

We'll release updates frequently during alpha.

### Check for Updates

```bash
# Check latest version
gh release list --repo Orizon-eu/fireline --limit 1

# Download and install latest
gh release download --repo Orizon-eu/fireline --pattern 'alpha-install.sh'
chmod +x alpha-install.sh
./alpha-install.sh
```

### Release Notes

Check release notes for each version:
- https://github.com/Orizon-eu/fireline/releases

---

## ❓ FAQ

**Q: Can I share Fireline with colleagues?**
A: No, access is individual. They should request alpha access at info@orizon.one

**Q: Is my data safe?**
A: Yes. Engagement data is encrypted at rest and in transit. See our [Privacy Policy](https://orizon.one/privacy).

**Q: Can I use Fireline commercially?**
A: During alpha, only for testing. Commercial use requires a separate license (coming in beta).

**Q: What if I find a security vulnerability?**
A: Report immediately to info@orizon.one. Do not disclose publicly.

**Q: Can I record demos or write about Fireline?**
A: Yes, but mark content as "Alpha" and include disclaimers. No NDA required.

**Q: Will my alpha feedback be implemented?**
A: We review all feedback. Priority features voted by alpha testers will be fast-tracked.

**Q: How do I leave the alpha program?**
A: Email info@orizon.one. Your access will be revoked and data deleted.

---

## 🙏 Thank You!

Your participation in the Fireline alpha is invaluable. Your feedback will help us build the best AI-powered pentesting tool.

**Questions?** info@orizon.one

---

**Happy Testing! 🔥**

*Orizon Security Team*
