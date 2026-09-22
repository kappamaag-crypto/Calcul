# ORIGINAL LOG PART 04/08

- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=2:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=2
curl: (28) Connection timed out after 2000 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=2
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=2
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=2:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=2
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=2
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=2:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=2
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=2
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=2
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=2:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=2
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=2
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=2:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=2
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=2
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=2
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=2:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=2
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=2
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=2:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=2
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=2
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=2
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=2:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=2
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=2
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=2:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=2
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=2
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=2
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=2:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=2
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=2
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=2:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=2
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=2
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=2
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=2:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=2
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=2
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=2:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=2
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=2
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=2
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=2:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=2
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=2
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=2:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=2:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_ttl=3
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_ttl=3
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_ttl=3
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_ttl=3
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_ttl=3
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=2:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=3
      0 [main] winws2 (2608) child_copy: cygheap read copy failed, 0x0..0x800029438, done 0, windows pid 2608, Win32 error 299
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=3
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=3
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=3
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=3
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=3
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=3
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=3
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=3
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=3
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2018 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=3
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=3
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=3
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=3
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=3
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=3
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=3
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=3
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=3
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=3
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=3
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=3
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=3
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=3
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=3
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
!!!!! AVAILABLE !!!!!
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=3
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=3
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=3
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=3
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=3
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=3
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=3
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=3
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=3
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=3
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
      0 [main] winws2 (6020) child_copy: cygheap read copy failed, 0x0..0x800029528, done 0, windows pid 6020, Win32 error 299
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:ip_ttl=3:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=3 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_md5
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_md5
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_md5
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_md5
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_md5
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_md5
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_md5
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_md5
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_md5
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_md5
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_md5
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_md5
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_md5
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_md5
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_md5
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_md5
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_md5
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_md5
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_md5
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_md5
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_md5
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_md5
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_md5
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_md5
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_md5
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_md5
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_md5
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_md5
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_md5
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_md5
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_md5
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_md5
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_md5
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_md5
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_md5
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_md5
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_md5
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_md5
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_md5
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_md5
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_md5:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_md5 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=fakeddisorder:pos=2:badsum
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fakeddisorder:pos=2:badsum
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=2:badsum
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=2:badsum
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=2:badsum
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=fakeddisorder:pos=1:badsum
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fakeddisorder:pos=1:badsum
curl: (28) Connection timed out after 2000 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:badsum
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:badsum
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:badsum
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:badsum
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:badsum
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:badsum
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:badsum
      0 [main] winws2 (23860) child_copy: cygheap read copy failed, 0x0..0x800029438, done 0, windows pid 23860, Win32 error 299
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:badsum
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:badsum
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:badsum
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:badsum
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:badsum
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:badsum
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=fakeddisorder:pos=host+1:badsum
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fakeddisorder:pos=host+1:badsum
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=host+1:badsum
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:badsum
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:badsum
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=fakeddisorder:pos=midsld:badsum
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fakeddisorder:pos=midsld:badsum
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:badsum
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:badsum
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:badsum
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:badsum
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:badsum
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:badsum
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:badsum
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:badsum
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:badsum
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:badsum
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:badsum
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:badsum:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:badsum
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:badsum:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:badsum
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_seq=-3000
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_seq=-3000
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_seq=-3000
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_seq=-3000
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_seq=-3000
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_seq=-3000
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_seq=-3000
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_seq=-3000
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_seq=-3000
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_seq=-3000
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_seq=-3000
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_seq=-3000
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_seq=-3000
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_seq=-3000
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_seq=-3000
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_seq=-3000
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_seq=-3000
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_seq=-3000
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_seq=-3000
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_seq=-3000
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_seq=-3000
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_seq=-3000
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_seq=-3000
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_seq=-3000
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_seq=-3000
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_seq=-3000
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_seq=-3000
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_seq=-3000
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_seq=-3000
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=midsld:tcp_seq=-3000
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_seq=-3000
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_seq=-3000
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_seq=-3000
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_seq=-3000
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,midsld:tcp_seq=-3000
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_seq=-3000
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_seq=-3000
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_seq=-3000
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=-3000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_seq=-3000
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=-3000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_seq=-3000
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_seq=1000000
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_seq=1000000
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_seq=1000000
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=1000000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_seq=1000000
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=2:tcp_seq=1000000
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_seq=1000000
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_seq=1000000
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_seq=1000000
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=1000000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_seq=1000000
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=1:tcp_seq=1000000
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_seq=1000000
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_seq=1000000
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_seq=1000000
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=1000000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_seq=1000000
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+1:tcp_seq=1000000
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_seq=1000000
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_seq=1000000
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_seq=1000000
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=multisplit:blob=fake_default_tls:tcp_seq=1000000:pos=2:nodrop:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_seq=1000000
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:tls_mod=rnd,dupsid,padencap:repeats=1 --lua-desync=fakeddisorder:pos=sniext+4:tcp_seq=1000000
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 youtube.com : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_seq=1000000:repeats=1 --lua-desync=fakeddisorder:pos=host+1:tcp_seq=1000000