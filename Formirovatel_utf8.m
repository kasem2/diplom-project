clear
f0 = 0
fs = 2.4e7
% Длительность посылки определяется как length/Tc, где Tc = 1200 -
% символьная скорость, length - число символов
R = 1200 % бод
progression = [1 0 1 1 0 0 1 1 0 1 0 0 1 1 1]; % Входной ЦП длиной 15
length_symbols = length(progression); %длина цифрового потока (число символов)
samp = fs/R; %число отсчетов в одном символе
samp_all = samp * length_symbols; %число отсчетов во всем сигнале
samp_all = double(samp_all);
%Длина последовательностей Голда 2^n - 1. Для примера выберем n =
%4,Следовательно длина будет 15
T = 1/R; %длительность одного символа
Tsum = T * length_symbols; %длительность всех символов)
% t = 0:1/fs:Tsum - (1/fs) %дискретное время
t = 0:1/fs:(samp_all -1)/ fs;
%tsym = t(end) - t(1) %длительность одного символа нормированная
%t = t' %Преобразование в вектор столбец для умножение потом на сигнал
%samp = int32(samp)
%samp_all = int32(samp_all)
temp = zeros(1, samp);
s = zeros(1, samp_all); %объявление сигнала ЛЧМ BPSK
alpha = 300e3; %девиация частоты
Fmax = f0 + alpha; %на всякий
phases = zeros(1, length_symbols);

%нормированное параметры
alpha_norm = alpha/fs;
f0_norm = f0/fs;
Fmax_norm = Fmax/fs;

%массив фаз
% for k = 1:length_symbols;
%     if mod(k,2) ~= 0;
%         phases(k) = 0;
%     else phases(k) = pi/2;
%     end;
% end;
for k = 1:length_symbols;
    if progression(k) == 1;
        phases(k) = pi/2;
    else phases(k) = 0;
    end
end    
%Алгоритм формирователя

index = 0;
for i = 1:length_symbols;
    t_local = (0:samp-1)/fs;
    if mod(i, 2) == 1;
        for m = 1:samp;
            t_local = (0:samp-1)/fs;
        start_t = ((i-1)*samp)+m;
        temp(m) = exp(1*j*(2*pi*(f0*t_local(m) + (alpha/(2*T))*t_local(m)^2) + phases(i)));
        s(((i-1)*samp)+m) = temp(m);    
        end
        
        else 
            for m = 1:samp;
        start_t = ((i-1)*samp)+m;
        temp(m) = exp(1*j*(2*pi*(Fmax *t_local(m) - (alpha/(2*T))*t_local(m)^2) + phases(i)));
        s(((i-1)*samp)+m) = temp(m);
            end
    end            
             
end          

     
s_dots  = zeros(1, samp_all);

% for i = 1:samp_all/samp
%     dots(i) = samp * i
% end

for i = 1:samp_all - 1;
    if mod(i, samp) == 0;
       s_dots(i) = s(i);
    end;
end;
s_dots(s_dots == 0) = NaN;


%Осциллограмма символов + сигнала
s_symb = zeros(1,samp_all);
for k = 1:length_symbols-1;
    if progression(k) == 1;
    s_symb(k*samp:(k+1)*samp) = 0.5;
        else if (progression(k)) == 0;
    s_symb(k*samp:(k+1)*samp) = 0;
            end;
    end;
end;
s_symb(end) = 0;
%plot(t,s_symb);
%ylim([0 0.6]);
% ax1 = subplot(2,2,1); % top subplot
% ax2 = subplot(2,2,2); % bottom subplot
% ax3 = subplot(1,2,4)
% 
% plot(ax1,t,real(s),'b', t,real(s_dots),'ro');
% ylim([-2 2]);
% plot(ax2,t, s_symb);
% grid on;



%Спектр
s_fft = fft(s);
N_fft = length(s_fft);
f_fft = (0:N_fft - 1) * (fs/samp_all);
 N_half = floor(N_fft/2); %половина коэффициентов fft
 f_fft_plot = f_fft(1:N_half); %половина частот от fft
 s_fft_plot = abs(s_fft(1:N_half)) * 2/N_fft;

%  plot(t(1:25000), s_symb(1:25000), 'b')
 
figure;
subplot(2,1,1)
plot(t(1:50000), s(1:50000), 'b', t(1:50000), s_dots(1:50000), 'ro')
ylim([-2 2])
title(['\fontsize{12} Осциллограмма гибридного сигнала ЛЧМ ФМ2 s(t)'])
xlabel('Дискретное время', 'FontSize', 12)
ylabel ('Значение сигнала', 'FontSize', 12)

subplot(2,1,2)
plot(t(1:50000), s_symb(1:50000), 'b')
title(['\fontsize{12} Информационная последовательность'])
xlabel('Длительность символа в отсчетах', 'FontSize', 12)
ylabel ('Значение информационного бита', 'FontSize', 12)

figure
plot(f_fft, s_fft)
title(['\fontsize{12} Спектр гибридного сигнала ЛЧМ ФМ2 S(f)'])
xlabel('Частота, Гц', 'FontSize', 12)
ylabel ('Амплитуда', 'FontSize', 12)










     
 
 







