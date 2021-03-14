%% nonlinear simulation

x1_current = -2;
x2_current = 1;
u_current = 0;

x1 = [];
x2 = [];
a = 9;
b = 10;
type =1;

fs = 200;                   % sampling frequency    [Hz]
dt = 1/fs;                  % time interval         [sec]
T = 20;                    % observation time      [sec]
t_full = [0:dt:T];          % time axis             
N = T/dt;                   % discrete number of samples
fres = fs/N;                % frequency resolution
freqHz = fres*(1:N/2);      % frequency axis        [Hz]
omega = 2*pi*freqHz;        % frequency axis        [rad]
W = 1.0;                      % noise intensity for both hor and vert

% build white noise signal
for i=1:N/2
    Sww(i) = W;
end

% continuous time input vectors definitions
rng('default')
u = randn(1,N+1)/sqrt(dt);

for i = 1:length(t_full)
    [dx1,dx2] = der1(x1_current, x2_current, u_current, a, b, type);
    x1_current = dt*dx1 + x1_current;
    x2_current = dt*dx2 + x2_current;
    u_current = u(i);
    x1 = [x1 x1_current];
    x2 = [x2 x2_current];
end

Xfft = fft(x1,N);

Sxx = (Xfft.*conj(Xfft)/N)*dt;

window_size = 0.2*N;
overlap = 0.5*window_size;

cx1u = xcov(x1,u);
cx2u = xcov(x2,u);
dtc = [-T:dt:T];

[Sxx_pw, ~] = pwelch(x1, window_size, overlap, N, fs, 'onesided');
Sxx_pw = (Sxx_pw/2);
Sxx_pw = Sxx_pw(2:N/2+1);

figure('visible', 'on');
plot(dtc,cx1u);
figure('visible', 'off')
plot(t_full,x1); hold on;
plot(t_full,x2);

set(0, 'defaultTextInterpreter', 'latex'); 
figure('visible', 'off')
loglog(freqHz, Sxx(1:N/2), 'b'); hold on; 
loglog(freqHz, Sxx_pw, 'r', 'LineWidth', 2.0);
xlabel('$\omega$ [rad/s]'); ylabel('$S_{xx}(\omega)$ [$\frac{1}{Hz}$]');
grid
axis(10.^[-2 2 -13 2]); axis(axis);
