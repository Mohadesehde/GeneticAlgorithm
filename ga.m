clear;
clc;

population=input('Enter the Population size:    ');
maxgeneration=input('Enter the Max number of iterations:    ');
pcrossover=input('Enter the probability of Crossover:    ');
pmutation=input('Enter the probability of Mutation:    ');
n=input('Enter the number of bits (at least 10):    ');
x1=input('Enter the lower bound:    ');
x2=input('Enter the upper bound:    ');
 
pool(population,n)=0;
newpool(population,n)=0;
fitness(population,1)=0;
arrayfx(maxgeneration)=0;
prob(population,1)=0;
 
% % /////////////////////////////    Initialize
for i=1:population
    for j=1:n
        if rand()<0.5
            pool(i,j)=0;
        else
            pool(i,j)=1;
        end
    end
end
% % //////////////////////////////   Main 
 for i=1:maxgeneration
% %  ///////////////////////////    Fitness
           for k=1:population
               sum=0;
               for z=1:n
                   sum=sum+pool(k,z)^(z-1);
               end
               x=x1+(sum/(2^(n-4) -1))*(x2-x1);
               myfunction;
               fitness (k,1)=func;
           end
% %    ////////////////////////    determine best f(x) each time
           arrayfx(i)=max(fitness);     
% %  //////////////////////////      calculate probability 
           sum=0;
           for k=1:population
                sum=sum +fitness(k,1);
           end
           for k=1:population
               prob(k,1)=fitness(k,1)/sum;
           end
% %  ////////////////////////  create  new population
           for j=1 :population/2
%   % /////////////////////////////          select parent 1
                r=rand();
                sum=0;
                for k=1:population
                    sum=sum+prob(k,1);
                    if (sum>=r)
                        break;
                    end
                end
                p1=k;
%   %   //////////////////////////        select parent 2
                r=rand();
                sum=0;
                for k=1:population
                    sum=sum+prob(k,1);
                    if (sum>=r)
                        break;
                    end
                end
                p2=k;
%     % //////////////////////////          crossover
             r=rand();
             test=1;
             if (r<pcrossover) 
                  test=0;
                  r = rand();
                  r=r*10;
                  r=ceil(r);
 
                  child1(1:r)=pool(p1,1:r);
                  child1(r:n)=pool(p2,r:n);

                 child2(1:r)=pool(p2,1:r);
                 child2(r:n)=pool(p1,r:n);      
             end
 
             if (test==1)  
                 child1(1:n)=pool(p1,1:n);
                 child2(1:n)=pool(p2,1:n); 
             end 
%     % ////////////////////       mutation 
             r=rand();
             if (r<pmutation)
                  r = rand();
                  r=r*10;
                  r=ceil(r);
 
                  if child1(r)==0
                      child1(r)=1;
                  else
                      child1(r)=0;
                  end
 
                  r = rand();
                  r=r*10;
                  r=ceil(r);
 
                  if child2(r)==0
                      child2(r)=1;
                  else
                      child2(r)=0;
                  end
             end

%     %  ///////////////////////////         add to new pool
            newpool(2*j-1,1:n)=child1(1:n);
            newpool(2*j,1:n)=child2(1:n);
           end    
% %  ///////////////////////////   replace population
 
    pool=newpool;
 
  end
 
  fx=max(arrayfx);
  
  arrt=1:maxgeneration;
  figure;
  plot(arrt,arrayfx);
  xlabel('Iteration')
  ylabel('Max f(x) per Iteration')
