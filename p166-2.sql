select level-1 grade, mybin(level-1) 확률, lpad('■', mybin(level - 1)*100 , '■') "막대 그래프"
from dual
connect by level < 12;