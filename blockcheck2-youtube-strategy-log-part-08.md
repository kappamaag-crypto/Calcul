# ORIGINAL LOG PART 08/08

UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=2:repeats=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=2:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=2:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=2:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=2:repeats=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=2:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=2:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=2:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=2:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=2:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=2:repeats=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=2:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=2:repeats=1
      0 [main] winws2 (22816) child_copy: cygheap read copy failed, 0x0..0x8000293E8, done 0, windows pid 22816, Win32 error 299
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=2:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=2:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=2:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=3:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=3:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=3:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=3:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=3:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=3:repeats=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=3:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=3:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=4:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=4:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=4:repeats=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=4:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=4:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=4:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=4:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=4:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=4:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=4:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=4:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=4:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=4:repeats=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=4:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=4:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=4:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=5:repeats=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=5:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=5:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=5:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=5:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=5:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=5:repeats=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=5:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=5:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=5:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=5:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=5:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=5:repeats=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=5:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=5:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=5:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=6:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=6:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=6:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=6:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=6:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=6:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=6:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=6:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=6:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=6:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=6:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=6:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=6:repeats=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=6:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=6:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=6:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=7:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=7:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=7:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=7:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=7:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=7:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=7:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=7:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=7:repeats=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=7:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=7:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=7:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2018 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=7:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=7:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=7:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=7:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=8:repeats=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=8:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=8:repeats=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=8:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=8:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=8:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=8:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=8:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=8:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=8:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=8:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=8:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=8:repeats=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=8:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=8:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=8:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=9:repeats=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=9:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=9:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=9:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=9:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=9:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=9:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=9:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=9:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=9:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=9:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=9:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=9:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=9:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=9:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=9:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=10:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=10:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=10:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=10:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=10:repeats=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=10:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=10:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=10:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=10:repeats=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=10:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=10:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=10:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=10:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=10:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=10:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=10:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=11:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=11:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=11:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=11:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=11:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=11:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=11:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=11:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=11:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=11:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=11:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=11:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=11:repeats=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=11:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=11:repeats=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=11:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=12:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_ttl=12:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=12:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_ttl=12:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=12:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_ttl=12:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=12:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_ttl=12:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=12:repeats=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=12:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=12:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=12:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=12:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_ttl=12:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=12:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_ttl=12:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:tcp_md5
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:tcp_md5
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:tcp_md5
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:tcp_md5
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:tcp_md5
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:tcp_md5
curl: (28) Connection timed out after 2018 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:tcp_md5
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_md5
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:badsum
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:badsum
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:badsum
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:badsum
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:badsum
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:badsum
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:badsum
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:badsum
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:tcp_seq=-3000
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:tcp_seq=-3000
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:tcp_seq=-3000
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:tcp_seq=-3000
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:tcp_seq=-3000
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:tcp_seq=-3000
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:tcp_seq=-3000
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_seq=-3000
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:tcp_seq=1000000
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:tcp_seq=1000000
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:tcp_seq=1000000
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:tcp_seq=1000000
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:tcp_seq=1000000
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:tcp_seq=1000000
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:tcp_seq=1000000
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_seq=1000000
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:tcp_ack=-66000:tcp_ts_up
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:tcp_ack=-66000:tcp_ts_up
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:tcp_ack=-66000:tcp_ts_up
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:tcp_ack=-66000:tcp_ts_up
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:tcp_ack=-66000:tcp_ts_up
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:tcp_ack=-66000:tcp_ts_up
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:tcp_ack=-66000:tcp_ts_up
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_ack=-66000:tcp_ts_up
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:tcp_ts=-1000
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:tcp_ts=-1000
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:tcp_ts=-1000
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:tcp_ts=-1000
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:tcp_ts=-1000
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:tcp_ts=-1000
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:tcp_ts=-1000
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_ts=-1000
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_flags_unset=ACK
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:tcp_flags_set=SYN
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:tcp_flags_set=SYN
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:tcp_flags_set=SYN
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:tcp_flags_set=SYN
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:tcp_flags_set=SYN
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_autottl=-1,3-20:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_autottl=-1,3-20:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_autottl=-1,3-20:repeats=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_autottl=-1,3-20:repeats=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_autottl=-1,3-20:repeats=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_autottl=-1,3-20:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_autottl=-1,3-20:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-1,3-20:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_autottl=-2,3-20:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_autottl=-2,3-20:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_autottl=-2,3-20:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_autottl=-2,3-20:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_autottl=-2,3-20:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_autottl=-2,3-20:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_autottl=-2,3-20:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-2,3-20:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_autottl=-3,3-20:repeats=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_autottl=-3,3-20:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_autottl=-3,3-20:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_autottl=-3,3-20:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_autottl=-3,3-20:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_autottl=-3,3-20:repeats=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_autottl=-3,3-20:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-3,3-20:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_autottl=-4,3-20:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_autottl=-4,3-20:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_autottl=-4,3-20:repeats=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_autottl=-4,3-20:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_autottl=-4,3-20:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_autottl=-4,3-20:repeats=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_autottl=-4,3-20:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,midsld:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-4,3-20:repeats=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_autottl=-5,3-20:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=2:ip_autottl=-5,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_autottl=-5,3-20:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=1:ip_autottl=-5,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_autottl=-5,3-20:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+1:ip_autottl=-5,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_https_tls12 ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=fakedsplit:pos=sniext+4:ip_autottl=-5,3-20:repeats=1
curl: (28) Connection timed out after 2014 milliseconds