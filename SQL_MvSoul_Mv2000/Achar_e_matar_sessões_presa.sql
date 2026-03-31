-- ALTER SYSTEM KILL SESSION  '997,49502'

select    nvl(S.USERNAME,'Internal') username
   ,nvl(S.TERMINAL,'None') terminal
   ,S.OsUser
   ,L.SID||','||S.SERIAL# Kill
   ,U1.NAME||'.'||substr(T1.NAME,1,20) tab
   ,S.ACTION
   ,decode(L.LMODE,1,'No Lock',
       2,'Row Share',
       3,'Row Exclusive',
       4,'Share',
       5,'Share Row Exclusive',
       6,'Exclusive',null) lmode
   ,decode(L.REQUEST,1,'No Lock',
       2,'Row Share',
       3,'Row Exclusive',
       4,'Share',
       5,'Share Row Exclusive',
       6,'Exclusive',null) request
   ,To_Char( Trunc(Sysdate) + L.CTime*( 1/(24*60*60) ), 'hh24:mi:ss' ) Tempo
from    V$LOCK L,
   V$SESSION S,
   SYS.USER$ U1,
   SYS.OBJ$ T1
where    L.SID = S.SID
AND    L.LMODE = 3
and    T1.OBJ# = decode(L.ID2,0,L.ID1,L.ID2)
and    U1.USER# = T1.OWNER#
and    S.TYPE != 'BACKGROUND'
order by l.ctime desc,1,2,6
