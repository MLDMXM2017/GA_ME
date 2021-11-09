% The mutation process of GA's chromosome
% input : old chromosomes
% output : new chromosomes
% The mutation rate : 0.2
function new_pop=variation(pop)
rate = 0.2;
[u,w]=size(pop); 
mutation_rate=find(rand(1,u)<1); 
n_pop=[];
if ~isempty(mutation_rate)  
    for i=1:length(mutation_rate)
        if i==1||judgepop(pop(1,:),pop(i,:))>= w * rate 
            locate=floor(rand*w)+1;   
            n_pop(i,:)=pop(mutation_rate(i),:);  
            if pop(mutation_rate(i),locate)==0   
                n_pop(i,locate)=1;
            else
                n_pop(i,locate)=0;
            end
        else
            x = round(w * rate);
            temp=randperm(400, x );
            n_pop(i,:)=pop(mutation_rate(i),:);
            for j=1:x
                if pop(mutation_rate(i),temp(j))==0   
                    n_pop(i,temp(j))=1;
                else
                    n_pop(i,temp(j))=0;
                end
            end
        end
    end
end

if ~isempty(n_pop)
    new_pop=n_pop;
else
    new_pop=[];
end
