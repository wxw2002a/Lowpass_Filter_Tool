function xin = generate_step_signal(n, t1, t2)
    % GENERATE_STEP_SIGNAL: Generates a binary step signal.
    %
    % The function creates a time vector from 0 to t1 with a sampling rate of n.
    % It then returns a signal that is 0 before time t2 and 1 from t2 onward.
    %
    % Parameters:
    %   n  - Sampling rate (number of samples per unit time), default is 100.
    %   t1 - Duration of the signal, default is 3.
    %   t2 - Time at which the step occurs, default is 0.005.
    %
    % Output:
    %   xin - A binary step signal.
    
    if nargin < 1, n = 100; end
    if nargin < 2, t1 = 3; end
    if nargin < 3, t2 = 0.005; end
    t = 0:1/n:t1;
    xin = double(t >= t2);
end
