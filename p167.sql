set serveroutput on

create or replace procedure probn
 ( p_mu in number,
   p_sig in number,
   p_bin in number)
is

   type arr_type is varray(9) of number(30);

  v_sim number(10) := 10000;
  v_rv number(20,7);
  v_mu number(10) := p_mu;
  v_sig number(10) := p_sig;
  v_nm arr_type := arr_type('',0,0,0,0,0,0,0,'');
  v_cnt arr_type := arr_type(0,0,0,0,0,0,0,0);
  v_rg arr_type := arr_type(-power(2,31),-3,-2,-1,0,1,2,3,power(2,32));

begin
   for i in v_nm.first+1..v_nm.last-1 loop
       v_nm(i) := v_mu-3*p_bin+(i-2)*p_bin;
   end loop;

  for i in 1..v_sim loop
      v_rv := dbms_random.normal*v_sig+v_mu;

        for i in 2..v_rg.count loop
             if v_rv >= v_mu+v_rg(i-1)*p_bin and v_rv < v_mu+v_rg(i)*p_bin then
                    v_cnt(i-1) := v_cnt(i-1)+1;
             end if;
        end loop;
  end loop;

  for i in 1..v_cnt.count loop
dbms_output.put_line(rpad(v_nm(i)||'~'||v_nm(i+1), 10, ' ')||lpad('  ',trunc((v_cnt(i)/v_sim)*100),'  '));
  end loop;
end;
/