# ORIGINAL LOG PART 05/08

LUA ERROR: INTERRUPT
desync ERROR. passing packet unmodified.
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+4
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=host+1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2000 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2000 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=2
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=2 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=2 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=2 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=2 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=2 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=sniext+1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=sniext+1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+4
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=sniext+4 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=sniext+4 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+4 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+4 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+4 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=host+1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=host+1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=host+1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=host+1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=host+1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=host+1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=midsld --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 3551 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=midsld --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=midsld --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=midsld --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=midsld --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1,midsld --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1,midsld --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+4
      0 [main] winws2 (12000) child_copy: cygheap read copy failed, 0x0..0x800029458, done 0, windows pid 12000, Win32 error 299
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=host+1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=host+1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=1,midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
LUA ERROR: INTERRUPT
desync ERROR. passing packet unmodified.
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=1000000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=1000000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=1000000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=1000000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=1000000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=1000000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=1000000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=1000000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=1000000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=2
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+4
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=host+1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=host+1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=1,midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ts=-1000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
LUA ERROR: INTERRUPT
desync ERROR. passing packet unmodified.
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=2
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ts=-1000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ts=-1000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ts=-1000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+4
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=sniext+4
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=host+1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ts=-1000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=host+1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=host+1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ts=-1000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=midsld
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=1,midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=1,midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ts=-1000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ts=-1000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,midsld,1220
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_ts=-1000:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_unset=ACK:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=2
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_unset=ACK:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=multisplit:pos=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_flags_unset=ACK:tls_mod=rnd,dupsid:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls13 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_flags_unset=ACK:pos=2:nodrop:repeats=1 --lua-desync=multisplit:pos=sniext+1
curl: (28) Connection timed out after 2002 milliseconds