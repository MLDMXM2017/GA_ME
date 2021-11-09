%The crossover process of GA's chromosome
function new_pop=crosspop(pop,change_rate)
[d,w]=size(pop);
m=randperm(d);%1~d rows random exchange
n_pop=zeros(d,w);
if rem(d,2)==0
   for i=1:2:d  
       if rand<change_rate
           locate=floor(rand*w)+1;  
           n_pop(i,:)=[pop(m(i),1:locate),pop(m(i+1),locate+1:w)];
           n_pop(i+1,:)=[pop(m(i+1),1:locate),pop(m(i),locate+1:w)];
       end
   end
else
   for i=1:2:d-1  
       if rand<change_rate
           locate=floor(rand*w)+1;  
           n_pop(i,:)=[pop(m(i),1:locate),pop(m(i+1),locate+1:w)];
           n_pop(i+1,:)=[pop(m(i+1),1:locate),pop(m(i),locate+1:w)];
       end
   end
end
new_pop=n_pop;