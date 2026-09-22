# ORIGINAL LOG PART 06/08

- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ts=-1000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_ts=-1000
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_ts=-1000
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_ts=-1000
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_ts=-1000
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_ts=-1000
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ts=-1000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_ts=-1000
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_ts=-1000
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_ts=-1000
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_ts=-1000
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_ts=-1000
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ts=-1000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_ts=-1000
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_ts=-1000
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_ts=-1000
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_ts=-1000
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_ts=-1000
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ts=-1000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_ts=-1000
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_ts=-1000
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_unset=ACK:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_unset=ACK:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_flags_unset=ACK
      0 [main] winws2 (24532) child_copy: cygheap read copy failed, 0x0..0x800029478, done 0, windows pid 24532, Win32 error 299
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_unset=ACK:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_unset=ACK:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_flags_unset=ACK
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_flags_unset=ACK
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_flags_unset=ACK
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_unset=ACK:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_flags_unset=ACK
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_flags_unset=ACK
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_flags_unset=ACK
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_unset=ACK:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_flags_unset=ACK
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_unset=ACK:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_unset=ACK:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_flags_set=SYN
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_flags_set=SYN
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_flags_set=SYN
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_set=SYN:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_flags_set=SYN
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_flags_set=SYN
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_set=SYN:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_set=SYN:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_flags_set=SYN
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_flags_set=SYN
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_flags_set=SYN
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_set=SYN:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_flags_set=SYN
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_flags_set=SYN
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_flags_set=SYN
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_flags_set=SYN
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_flags_set=SYN
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_set=SYN:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_flags_set=SYN
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_flags_set=SYN
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_flags_set=SYN
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_flags_set=SYN
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_flags_set=SYN
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_set=SYN:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_flags_set=SYN
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_flags_set=SYN
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_flags_set=SYN
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_flags_set=SYN
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_flags_set=SYN
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_set=SYN:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_flags_set=SYN
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_flags_set=SYN
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_set=SYN:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_set=SYN:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-1,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-1,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-1,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-1,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-1,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-1,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-1,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-1,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-1,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-1,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-1,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-1,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-1,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-1,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-1,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-1,3-20
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-1,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-2,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-2,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-2,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-2,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-2,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-2,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-2,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-2,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-2,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-2,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-2,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-2,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-2,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-2,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-2,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-2,3-20
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-2,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-3,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-3,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-3,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-3,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-3,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-3,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-3,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-3,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-3,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-3,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-3,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-3,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-3,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-3,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-3,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-3,3-20
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-3,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-4,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-4,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-4,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-4,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-4,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-4,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-4,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-4,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-4,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-4,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-4,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-4,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-4,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-4,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-4,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-4,3-20
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-4,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-5,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_autottl=-5,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-5,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_autottl=-5,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-5,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_autottl=-5,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-5,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_autottl=-5,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-5,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-5,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-5,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-5,3-20
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-5,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-5,3-20 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-5,3-20 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-5,3-20 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-5,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-5,3-20 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_autottl=-5,3-20 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_autottl=-5,3-20:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-5,3-20
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-5,3-20
!!!!! AVAILABLE !!!!!

* script : standard/60-fake-hostfake.sh

!!!!! curl_test_https_tls13: working strategy found for ipv4 youtube.com : winws2 --payload=tls_client_hello --lua-desync=tcpseg:pos=0,1:ip_id=rnd:repeats=1 !!!!!

clearing winws2 redirection

* curl_test_http3 ipv4 youtube.com
- checking without DPI bypass
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28

preparing winws2 redirection

* script : standard/90-quic.sh
- curl_test_http3 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-udp-out=443 --payload=quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=1
!!!!! AVAILABLE !!!!!
- curl_test_http3 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-udp-out=443 --payload=quic_initial --lua-desync=send:ipfrag:ipfrag_pos_udp=8 --lua-desync=drop
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http3 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-udp-out=443 --payload=quic_initial --lua-desync=send:ipfrag:ipfrag_pos_udp=16 --lua-desync=drop
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http3 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-udp-out=443 --payload=quic_initial --lua-desync=send:ipfrag:ipfrag_pos_udp=32 --lua-desync=drop
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http3 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-udp-out=443 --payload=quic_initial --lua-desync=send:ipfrag:ipfrag_pos_udp=64 --lua-desync=drop
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http3 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-udp-out=443 --payload=quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=1 --lua-desync=send:ipfrag:ipfrag_pos_udp=8 --lua-desync=drop
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http3 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-udp-out=443 --payload=quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=1 --lua-desync=send:ipfrag:ipfrag_pos_udp=16 --lua-desync=drop
!!!!! AVAILABLE !!!!!

!!!!! curl_test_http3: working strategy found for ipv4 youtube.com : winws2 --payload=quic_initial --lua-desync=fake:blob=fake_default_quic:repeats=1 !!!!!

clearing winws2 redirection

* port block tests ipv4 telegram.org:80
nc -z -w 2 149.154.167.99 80
149.154.167.99 does not connect. netcat code 1

* curl_test_http ipv4 telegram.org
- checking without DPI bypass
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28

- IP block tests (requires manual interpretation)
> testing iana.org on it's original ip
!!!!! AVAILABLE !!!!!
> testing telegram.org on 192.0.43.8 (iana.org)
HTTP/1.1 302 Found
Location: https://www.iana.org/
> testing iana.org on 149.154.167.99 (telegram.org)
curl: (28) Connection timed out after 2007 milliseconds

preparing winws2 redirection

* script : standard/10-http-basic.sh
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=http_hostcase
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=http_hostcase:spell=hoSt
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=http_domcase
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=http_methodeol
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=http_unixeol
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28

* script : standard/15-misc.sh
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=tcpseg:pos=0,method+2:ip_id=rnd:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=tcpseg:pos=0,midsld:ip_id=rnd:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=tcpseg:pos=0,method+2:ip_id=rnd:repeats=20
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=tcpseg:pos=0,midsld:ip_id=rnd:repeats=20
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=tcpseg:pos=0,method+2:ip_id=rnd:repeats=100
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=tcpseg:pos=0,midsld:ip_id=rnd:repeats=100
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=tcpseg:pos=0,method+2:ip_id=rnd:repeats=260
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=tcpseg:pos=0,midsld:ip_id=rnd:repeats=260
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28

* script : standard/17-oob.sh
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --in-range=-s1 --lua-desync=oob:urp=b
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --in-range=-s1 --lua-desync=oob:urp=0
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --in-range=-s1 --lua-desync=oob:urp=2
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --in-range=-s1 --lua-desync=oob:urp=midsld
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28

* script : standard/20-multi.sh
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=multisplit:pos=method+2
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=multisplit:pos=method+2,midsld
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=multidisorder:pos=method+2
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=multidisorder:pos=midsld
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=multidisorder:pos=method+2,midsld
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28

* script : standard/23-seqovl.sh
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=tcpseg:pos=0,-1:seqovl=1 --lua-desync=drop
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=tcpseg:pos=0,-1:seqovl=#fake_default_http:seqovl_pattern=fake_default_http --lua-desync=drop
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=multisplit:pos=method+2:seqovl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=multisplit:pos=method+2:seqovl=#fake_default_http:seqovl_pattern=fake_default_http
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=multisplit:pos=method+2,midsld:seqovl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=multisplit:pos=method+2,midsld:seqovl=#fake_default_http:seqovl_pattern=fake_default_http
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28