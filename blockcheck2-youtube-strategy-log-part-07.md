# ORIGINAL LOG PART 07/08

UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_flags_set=SYN:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-1,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-1,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-1,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-1,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-1,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-1,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-2,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-2,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-2,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-2,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-2,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-2,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-3,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-3,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-3,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-3,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-3,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-3,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-4,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-4,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2018 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-4,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-4,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-4,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-4,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-5,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-5,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-5,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-5,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
      1 [main] winws2 (12644) child_copy: cygheap read copy failed, 0x0..0x8000294D8, done 0, windows pid 12644, Win32 error 299
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=multidisorder:pos=midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-5,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-5,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=multidisorder:pos=method+2,midsld --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28

* script : standard/55-fake-faked.sh
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=1:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=1:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=1:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=1:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=1:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=1:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=1:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=1:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=1:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=1:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=1:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=1:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=2:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=2:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=2:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=2:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=2:repeats=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=2:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=2:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=2:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=2:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=2:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=2:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=2:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=2:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=2:repeats=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=2:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=2:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=2:repeats=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=2:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=2:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=3:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=3:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=3:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=3:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=3:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=3:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=3:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=3:repeats=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=3:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=3:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=3:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
      0 [main] winws2 (2256) child_copy: cygheap read copy failed, 0x0..0x8000294F8, done 0, windows pid 2256, Win32 error 299
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=3:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=3:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=4:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=4:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=4:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=4:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=4:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=4:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=4:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=4:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=4:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=4:repeats=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=4:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=4:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=4:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=4:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=4:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=4:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=4:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=4:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=4:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=4:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=4:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=4:repeats=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=4:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=4:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=5:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=5:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=5:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=5:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=5:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=5:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=5:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=5:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=5:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=5:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=5:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=5:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=5:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=5:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=5:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=5:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=5:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=5:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=5:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=5:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=5:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=5:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=5:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=5:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=6:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=6:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=6:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=6:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=6:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=6:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=6:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=6:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=6:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=6:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=6:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=6:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=6:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=6:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=6:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=6:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=6:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=6:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=6:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=6:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=6:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=6:repeats=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=6:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=6:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=7:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=7:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=7:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=7:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=7:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=7:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=7:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=7:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=7:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=7:repeats=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=7:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=7:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=7:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=7:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=7:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=7:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=7:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=7:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=7:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=7:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=7:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=7:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=7:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=7:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=8:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=8:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=8:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=8:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=8:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=8:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=8:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=8:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=8:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=8:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=8:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=8:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=8:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=8:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=8:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=8:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=8:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=8:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=8:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=8:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=8:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=8:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=8:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=8:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=9:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=9:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=9:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=9:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=9:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=9:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=9:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=9:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=9:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=9:repeats=1
curl: (28) Connection timed out after 2018 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=9:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=9:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=9:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=9:repeats=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=9:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=9:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=9:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=9:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=9:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=9:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=9:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=9:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=9:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=9:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=10:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=10:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=10:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=10:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=10:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=10:repeats=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=10:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=10:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=10:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=10:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=10:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=10:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=10:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=10:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=10:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=10:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=10:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=10:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=10:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=10:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=10:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=10:repeats=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=10:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=10:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=11:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=11:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=11:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=11:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=11:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=11:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=11:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=11:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=11:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=11:repeats=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=11:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=11:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=11:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=11:repeats=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=11:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=11:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=11:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=11:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=11:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=11:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=11:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=11:repeats=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=11:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=11:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=12:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=12:repeats=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=12:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=12:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=12:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=12:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=12:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_ttl=12:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=12:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=12:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=12:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=12:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=12:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=12:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=12:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_ttl=12:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=12:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=12:repeats=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=12:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=12:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=12:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=12:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=12:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_ttl=12:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_md5:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_md5:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_md5:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_md5:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_md5:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_md5:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_md5:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_md5:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_md5:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_md5:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_md5:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_md5:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_md5:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:badsum:repeats=1 --lua-desync=fakedsplit:pos=method+2:badsum:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fakedsplit:pos=method+2:badsum:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:badsum:repeats=1 --lua-desync=fakedsplit:pos=midsld:badsum:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fakedsplit:pos=midsld:badsum:repeats=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:badsum:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:badsum:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:badsum:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:badsum:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_seq=-3000:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_seq=-3000:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_seq=-3000:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_seq=-3000:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_seq=-3000:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_seq=-3000:repeats=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_seq=-3000:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_seq=-3000:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_seq=-3000:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_seq=-3000:repeats=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_seq=1000000:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_seq=1000000:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_seq=1000000:repeats=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_seq=1000000:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_seq=1000000:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_seq=1000000:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_seq=1000000:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_seq=1000000:repeats=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_seq=1000000:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_seq=1000000:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_ack=-66000:tcp_ts_up:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_ack=-66000:tcp_ts_up:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_ack=-66000:tcp_ts_up:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_ack=-66000:tcp_ts_up:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_ack=-66000:tcp_ts_up:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_ack=-66000:tcp_ts_up:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_ack=-66000:tcp_ts_up:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_ts=-1000:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_ts=-1000:repeats=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_ts=-1000:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_ts=-1000:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_ts=-1000:repeats=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_ts=-1000:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_ts=-1000:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_ts=-1000:repeats=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_ts=-1000:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_ts=-1000:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_flags_unset=ACK:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_flags_unset=ACK:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_flags_unset=ACK:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_flags_unset=ACK:repeats=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_flags_unset=ACK:repeats=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_flags_unset=ACK:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_flags_unset=ACK:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_flags_set=SYN:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_flags_set=SYN:repeats=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fakedsplit:pos=method+2:tcp_flags_set=SYN:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_flags_set=SYN:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_flags_set=SYN:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fakedsplit:pos=midsld:tcp_flags_set=SYN:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:tcp_flags_set=SYN:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_flags_set=SYN:repeats=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:tcp_flags_set=SYN:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:tcp_flags_set=SYN:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-1,3-20:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-1,3-20:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-1,3-20:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2011 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-1,3-20:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-1,3-20:repeats=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-1,3-20:repeats=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-1,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-2,3-20:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-2,3-20:repeats=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-2,3-20:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-2,3-20:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-2,3-20:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-2,3-20:repeats=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-2,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-3,3-20:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-3,3-20:repeats=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-3,3-20:repeats=1
curl: (28) Connection timed out after 2002 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-3,3-20:repeats=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-3,3-20:repeats=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2005 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-3,3-20:repeats=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-3,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2003 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-4,3-20:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-4,3-20:repeats=1
curl: (28) Connection timed out after 2017 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-4,3-20:repeats=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-4,3-20:repeats=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-4,3-20:repeats=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-4,3-20:repeats=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-4,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-5,3-20:repeats=1
curl: (28) Connection timed out after 2006 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-5,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2010 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-5,3-20:repeats=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2:ip_autottl=-5,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2015 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-5,3-20:repeats=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-5,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-5,3-20:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakedsplit:pos=midsld:ip_autottl=-5,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-5,3-20:repeats=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-5,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2016 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-5,3-20:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_autottl=-5,3-20:repeats=1 --lua-desync=fakedsplit:pos=method+2,midsld:ip_autottl=-5,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2012 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=1:repeats=1 --lua-desync=fakeddisorder:pos=method+2:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=1:repeats=1 --lua-desync=fakeddisorder:pos=method+2:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2001 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=1:repeats=1 --lua-desync=fakeddisorder:pos=method+2:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=1:repeats=1 --lua-desync=fakeddisorder:pos=method+2:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2008 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=1:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=1:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=1:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2013 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=1:repeats=1 --lua-desync=fakeddisorder:pos=midsld:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=1:repeats=1 --lua-desync=fakeddisorder:pos=method+2,midsld:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2014 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=fake_default_http:ip_ttl=1:repeats=1 --lua-desync=fakeddisorder:pos=method+2,midsld:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2007 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=1:repeats=1 --lua-desync=fakeddisorder:pos=method+2,midsld:ip_ttl=1:repeats=1
curl: (28) Connection timed out after 2004 milliseconds
UNAVAILABLE code=28
- curl_test_http ipv4 telegram.org : winws2 --wf-l3=ipv4 --wf-tcp-out=80 --payload=http_req --lua-desync=fake:blob=0x00000000:ip_ttl=1:repeats=1 --lua-desync=fakeddisorder:pos=method+2,midsld:ip_ttl=1:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1
curl: (28) Connection timed out after 2009 milliseconds