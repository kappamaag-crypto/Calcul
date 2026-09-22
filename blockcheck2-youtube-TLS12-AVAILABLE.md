# blockcheck2 YouTube — complete strategy inventory

Source: blockcheck2-youtube-tls12-standard(1).log

Matrix: standard; youtube.com; IPv4; HTTP=N; TLS1.2=Y; TLS1.3=Y; QUIC/HTTP3=Y; repeats=1; parallel=N; scan level=standard.

Counts: TLS1.2=86; TLS1.3=0; QUIC=0; common=0.

## TLS 1.2 (86)

1. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=host+1`
2. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=midsld`
3. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=1,midsld`
4. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=1,midsld,1220`
5. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=1,sniext+1,host+1,midsld-2,midsld,midsld+2,endhost-1`
6. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multisplit:pos=10,midsld:seqovl=1`
7. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=midsld:seqovl=midsld-1`
8. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-init=fake_default_tls=tls_mod(fake_default_tls,'rnd') --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=midsld:seqovl=midsld-1:seqovl_pattern=fake_default_tls`
9. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=2,midsld:seqovl=1`
10. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-init=fake_default_tls=tls_mod(fake_default_tls,'rnd') --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=multidisorder:pos=2,midsld:seqovl=1:seqovl_pattern=fake_default_tls`
11. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_ttl=3:tls_mod=rnd,dupsid,padencap:repeats=1`
12. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1`
13. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_md5:tls_mod=rnd,dupsid,padencap:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5`
14. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ack=-66000:tcp_ts_up:tls_mod=rnd,dupsid,padencap:repeats=1`
15. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:tcp_ts=-1000:tls_mod=rnd,dupsid,padencap:repeats=1`
16. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-1,3-20:tls_mod=rnd,dupsid,padencap:repeats=1`
17. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-2,3-20:tls_mod=rnd,dupsid,padencap:repeats=1`
18. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-3,3-20:tls_mod=rnd,dupsid,padencap:repeats=1`
19. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-4,3-20:tls_mod=rnd,dupsid,padencap:repeats=1`
20. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fake:blob=fake_default_tls:ip_autottl=-5,3-20:tls_mod=rnd,dupsid,padencap:repeats=1`
21. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
22. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_ttl=3:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
23. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5`
24. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5`
25. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:tcp_seq=-3000`
26. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:tcp_seq=-3000`
27. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:tcp_ack=-66000:tcp_ts_up`
28. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:tcp_ts=-1000`
29. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:tcp_ts=-1000`
30. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
31. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
32. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
33. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
34. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
35. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
36. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
37. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
38. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=host+1:ip_autottl=-5,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
39. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakedsplit:pos=midsld:ip_autottl=-5,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
40. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=host+1:ip_ttl=1:repeats=1`
41. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=midsld:ip_ttl=1:repeats=1`
42. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=host+1:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5`
43. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=midsld:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5`
44. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=host+1:badsum`
45. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=midsld:badsum`
46. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=host+1:tcp_seq=-3000`
47. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=midsld:tcp_seq=-3000`
48. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=host+1:tcp_seq=1000000`
49. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=midsld:tcp_seq=1000000`
50. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=host+1:tcp_ack=-66000:tcp_ts_up`
51. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=midsld:tcp_ack=-66000:tcp_ts_up`
52. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=host+1:tcp_ts=-1000`
53. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=midsld:tcp_ts=-1000`
54. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=host+1:tcp_flags_unset=ACK`
55. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=midsld:tcp_flags_unset=ACK`
56. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=host+1:tcp_flags_set=SYN`
57. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=midsld:tcp_flags_set=SYN`
58. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-1,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
59. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
60. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-2,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
61. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
62. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-3,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
63. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
64. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-4,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
65. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=host+1:ip_autottl=-5,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
66. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --lua-desync=wssize:wsize=1:scale=6 --payload=tls_client_hello --lua-desync=fakeddisorder:pos=midsld:ip_autottl=-5,3-20:repeats=1 --payload=empty --out-range=s1<d1 --lua-desync=pktmod:ip_ttl=1`
67. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:ip_ttl=3:repeats=1`
68. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:nofake2:ip_ttl=3:repeats=1`
69. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:disorder_after:ip_ttl=3:repeats=1`
70. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:disorder_after:nofake2:ip_ttl=3:repeats=1`
71. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:tcp_md5:repeats=1`
72. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:nofake2:tcp_md5:repeats=1`
73. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:disorder_after:tcp_md5:repeats=1`
74. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:disorder_after:nofake2:tcp_md5:repeats=1`
75. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5`
76. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:nofake2:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5`
77. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:disorder_after:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5`
78. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:disorder_after:nofake2:tcp_md5:repeats=1 --payload=empty --out-range=<s1 --lua-desync=send:tcp_md5`
79. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:tcp_ack=-66000:tcp_ts_up:repeats=1`
80. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:nofake2:tcp_ack=-66000:tcp_ts_up:repeats=1`
81. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:disorder_after:tcp_ack=-66000:tcp_ts_up:repeats=1`
82. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:disorder_after:nofake2:tcp_ack=-66000:tcp_ts_up:repeats=1`
83. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:tcp_ts=-1000:repeats=1`
84. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:nofake2:tcp_ts=-1000:repeats=1`
85. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:disorder_after:tcp_ts=-1000:repeats=1`
86. `winws2 --wf-l3=ipv4 --wf-tcp-out=443 --payload=tls_client_hello --lua-desync=hostfakesplit:disorder_after:nofake2:tcp_ts=-1000:repeats=1`
