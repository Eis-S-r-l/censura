Blacklists for Italian Network Operators

Italian Network Operators MUST implement at least five different
blacklists (DNS sinkhole) in order to comply with Italian laws.

It means that customers using their Italian ISP's resolvers must not reach those
forbidden resources.

There are four main types of lists:

- CNCPO (child pornography sites)
- AAMS (illegal gambling sites and illegal tobacco sites)
- AGCOM (copyright infringement cases)
- MANUAL (lists provided by Italian LEAs or other Authorities)

Here is a bundle of scripts able to get the lists, parse the data and produce a
DNS file (currently for Bind, Unbound, and PowerDNS) to hijack some queries toward a customized stop
page.

> :warning: **CNCPO requires the ISP to register**: Once the registration has completed they provide a .pfx certificate (PKCS#12) with a password. This will be later used as a client certificate to pull the list from their web server. This certificate must converted to the PEM format with the following commands (thanks to Daniele Carlini for the feedback):
```bash
openssl enc -base64 -d -in cncpo.pfx -out cncpo-base64.pfx
openssl pkcs12 -in cncpo-base64.pfx -out cncpo.pem  -clcerts -nodes
```

### Requirements

These scripts require the following packages to be installed and configured in order to work:

- Python 3
- msmtp (only required if you want to enable e-mail notifications)

### Installation

Here is an example of how to install the scripts for Debian. 
The following commands are run as the root user:
```bash
apt install git python3 python3-pip msmtp
git clone https://github.com/Eis-S-r-l/censura.git
cd censura
pip install -r requirements.txt
```

### Configuration

All of the configurable parameters are in the [parameters.sh](parameters.sh) file for comfort.

If you intend to use e-mail alerts you need to also have msmtp properly configured and working.

### Disclaimer

While Eis S.r.l. make every effort to deliver high quality products, we do not
guarantee that our products are free from defects. Our software is provided “as is," and you use the
software at your own risk.

We make no warranties as to performance, merchantability, fitness for a particular purpose, or any
other warranties whether expressed or implied.

No oral or written communication from or information provided by Eis S.r.l.
shall create a warranty.

Under no circumstances shall Eis S.r.l. be liable for direct, indirect, special,
incidental, or consequential damages resulting from the use, misuse, or inability to use this software,
even if Eis S.r.l. has been advised of the possibility of such damages.

### Credits

The scripts in [censura](https://github.com/mphilosopher/censura) that inspired this fork

The tool in [kit-censura](https://github.com/rfc1036/kit-censura)  
