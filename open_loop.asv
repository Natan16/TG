dp/dt + n = -Lpp*(p + m) + beta_rolamento*Fex*l/Ixx + perturbation ; %talvez a flutuação nos momentos
% erros de 5%
%inércia não seja desprezível
%a perturbação do vento pode ser interpretada como uma flutuação na força
%externa ou um ruído ( apesar de o vento não ser aleatório )
state = 1;
Fex = 0;
if p > w_roll 
    Fex = -F;
    state = 2;
end
if p < -w_roll
    Fex = F ;
    state = 2;
end

if 0 < p && p < w_lim && state == 2
    Fex = 0 ;
    state = 1 ;
end
if 0 > p && p > - w_lim && state == 2
    Fex = 0;
    state = 1;
end
%w_lim tem que ser tal que o uma rajada de tempo não seja capaz de levar o
%sistema de w_lim para mais que w_roll antes que o sistema seja capaz de reagir

%colocar os ventos