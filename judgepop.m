% The elemental difference between the two chromosomes
function percent=judgepop(pop1,pop2)
[~,w]=size(pop1);
m=0;
for i=1:w
    if pop1(i)~=pop2(i)
        m=m+1;
    end
end
percent=m;
end