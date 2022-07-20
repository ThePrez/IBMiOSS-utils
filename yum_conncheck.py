#!/QOpenSys/pkgs/bin/python2.7
import socket;
import ssl;
import locale;
from traceback import print_exc;
from os.path import exists;

locale.setlocale(locale.LC_ALL, 'EN_US.UTF-8');

hostname='public.dhe.ibm.com'
ip='129.35.224.112'
timeout=30

def check_alternative_protos():
  print 'Checking if alternative protocols might work...'
  try:
    socket.create_connection((hostname,80), timeout)
    print 'HTTP protocol should work!'
    print 'To try it, run:'
    if exists('/QOpenSys/etc/yum/repos.d/ibmi-release-unsecure.repo'):
      print '    /QOpenSys/pkgs/bin/yum-config-manager --enable-repo=ibmi-base-unsecure'
      print '    /QOpenSys/pkgs/bin/yum-config-manager --enable-repo=ibmi-release-unsecure'
    else:
      print '    /QOpenSys/pkgs/bin/yum-config-manager  --setopt=ibm.baseurl=http://public.dhe.ibm.com/software/ibmi/products/pase/rpms/repo'
  except:
    try:
      socket.create_connection((hostname,21), timeout)
      print 'FTP should work!'
      return
    except Exception as e: 
        print 'No luck: '+str(e)
print "Checking to see connectivity via TLS..."
try:
  ssl.create_default_context().wrap_socket(socket.create_connection((hostname,443), timeout), server_hostname=hostname)
  print 'Looks good! If you are having issues, maybe try renaming the legacy repo file by running:'
  print '    mv /QOpenSys/etc/yum/repos.d/ibm.repo /QOpenSys/etc/yum/repos.d/ibm.repo.backup'
except (socket.error, socket.timeout):
  print 'Could not connect to %s' % hostname
  check_alternative_protos();
except (socket.herror, socket.gaierror):
  print 'name lookup failed'
  print ''
  print 'Your DNS is not configured properly and cannot look up host ' + hostname
  print 'Please work with your IBM i administrator or network team to configure DNS properly!'
  print ''
  print 'You can implement a temporary workaround by running:'
  print '    system "ADDTCPHTE INTNETADR(\'%s\') HOSTNAME((public.dhe.ibm.com))"' % ip
  print 'NOTE: If this IP changes, you will need to create a new host list entry in the future'
  exit(5)
except ssl.CertificateError as e:
  message = str(e)
  print 'SSL certificate error: '+message
  
  if "doesn't match" in message:
    print 'Looks like some entity is injecting an unrecognized SSL certificate'
    print 'See this page for guidance on adding a new certificate to your system:'
    print '    https://www.seidengroup.com/2021/04/26/how-to-validate-self-signed-ssl-tls-certificates-from-ibm-i/'
    print ''
    print 'Checking for another workaround...'
  print 'Checking if disabling SSL verification works around the problem...'
  try:
    socket.create_connection((hostname,80), timeout)
    print 'Connectivity works without SSL verification!'
    print 'You need to temporarily disable the SSL certificate checker and install ca-certificates-mozilla'
    print 'to do so, run the following commands:'
    if exists('/QOpenSys/etc/yum/repos.d/ibmi-base.repo'):
      print '    /QOpenSys/pkgs/bin/yum-config-manager --save --setopt=ibmi-base.sslverify=0'
      print '    /QOpenSys/pkgs/bin/yum install ca-certificates-mozilla'
      print '    /QOpenSys/pkgs/bin/yum-config-manager --save --setopt=ibmi-base.sslverify=1'
    else:
      print '    /QOpenSys/pkgs/bin/yum-config-manager --save --setopt=ibm.sslverify=0'
      print '    /QOpenSys/pkgs/bin/yum install ca-certificates-mozilla'
      print '    /QOpenSys/pkgs/bin/yum-config-manager --save --setopt=ibm.sslverify=1'
  except Exception as e:
    print 'Error: '+str(e)
    check_alternative_protos()
except Exception as e:
  print 'Unknown error: '+str(e)
