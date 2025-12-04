# Security Policy

## Supported Versions

We release patches for security vulnerabilities in the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |

## Reporting a Vulnerability

**⚠️ DO NOT create a public GitHub issue for security vulnerabilities**

If you discover a security vulnerability in Fireline, please report it responsibly:

### 🔒 Private Disclosure Process

1. **Email**: Send details to **info@orizon.one**
2. **Subject**: Use subject line: `[SECURITY] Fireline Vulnerability Report`
3. **Include**:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Your suggested fix (if any)

### ⏱️ Response Timeline

- **Initial Response**: Within 48 hours
- **Status Update**: Within 7 days
- **Fix Timeline**: Depends on severity (Critical: 7 days, High: 14 days, Medium: 30 days)

### 🎁 Recognition

We appreciate security researchers who help us keep Fireline secure:
- Public acknowledgment in release notes (if desired)
- Credit in SECURITY.md
- Swag and rewards for critical findings (at our discretion)

### 🔐 Encryption (Optional)

For highly sensitive reports, you may use PGP encryption:
- **PGP Key**: Available at https://orizon.one/pgp
- **Fingerprint**: Contact info@orizon.one for verification

## Security Best Practices

### For Users

When using Fireline for authorized penetration testing:

1. **API Keys**: Store your Fireline API key securely
   - Never commit API keys to version control
   - Use environment variables or secure credential storage
   - Rotate keys regularly

2. **Container Security**: Keep Docker/Podman updated
   - Use latest container runtime versions
   - Review container permissions
   - Isolate test environments

3. **Network Security**: Test only authorized targets
   - Maintain written authorization documents
   - Define clear scope boundaries
   - Use VPNs for sensitive engagements

4. **Logging**: Secure your engagement logs
   - Encrypt sensitive findings
   - Store logs on encrypted volumes
   - Follow data retention policies

### For Developers

If you're contributing or integrating with Fireline:

1. **Dependencies**: Keep dependencies updated
   - Regularly check for security advisories
   - Use `cargo audit` for Rust dependencies
   - Review third-party tool updates

2. **Code Review**: Security-focused reviews
   - Check for injection vulnerabilities
   - Validate all input
   - Follow secure coding practices

3. **Secrets Management**: Never hardcode secrets
   - Use environment variables
   - Implement key rotation
   - Use secret management tools

## Known Security Considerations

### ⚠️ By Design

Fireline is a penetration testing tool that:
- Executes security tools in containers
- Accesses network resources
- May trigger security alerts
- Requires elevated permissions for some tools

**This is intentional behavior for authorized security testing only.**

### 🛡️ Security Features

- **Container Isolation**: Tools run in sandboxed containers
- **API Key Authentication**: Secure authentication with Orizon services
- **Rate Limiting**: Built-in rate limits to prevent abuse
- **Usage Tracking**: Comprehensive logging for audit trails
- **HTTPS Only**: All API communication over TLS 1.3

## Security Updates

Subscribe to security updates:
- **GitHub Watch**: Watch this repository for security advisories
- **Email**: Subscribe at https://fireline.orizon.one/security
- **RSS**: Follow our security blog at https://orizon.one/blog/security

## Compliance

Fireline is designed to assist with:
- PCI DSS security testing requirements
- SOC 2 Type II penetration testing
- ISO 27001 vulnerability assessments
- NIST Cybersecurity Framework compliance testing

**Note**: Compliance responsibility remains with the organization conducting testing.

## Legal Notice

### Authorized Use Only

Fireline is designed for **authorized security testing only**. Unauthorized access to computer systems is illegal and may result in criminal prosecution under:

- 🇺🇸 Computer Fraud and Abuse Act (CFAA) - 18 U.S.C. § 1030
- 🇬🇧 Computer Misuse Act 1990
- 🇪🇺 EU Directive 2013/40/EU
- 🌍 Similar laws worldwide

### Liability

By using Fireline, you acknowledge:
- You have explicit written authorization for all testing
- You accept full responsibility for your actions
- Orizon is not liable for misuse of this tool

## Contact

- **Security Issues**: info@orizon.one
- **General Support**: info@orizon.one
- **Website**: https://fireline.orizon.one

---

**Thank you for helping keep Fireline secure!**
