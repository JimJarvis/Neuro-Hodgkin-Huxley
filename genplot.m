function genplot(varargin)
% Generate a plot with captions
% (title, X_vals, 'xlabel', Y_vals, 'ylabel')
% 'xlabel' and 'ylabel' are optional
% title can be either a string
% or a cell array {string, Latex_title=0-2, Latex_xlabel, Latex_ylabel}
% the 3 options are optional. Default 0, 2, 2.
% 0: no latex
% 1: partial latex (need to type $$___$$ manually)
% 2: full latex (assume enclosed by $$ $$)

x_vals = [];
x_label = '';
y_vals = [];
y_label = '';
ttext = '';

latex_title = 0;
latex_x = 2;
latex_y = 2;

tt = varargin{1};

if iscell(tt)
  % optional logicals
  ttext = tt{1};
  if numel(tt) > 1, latex_title = tt{2}; end
  if numel(tt) > 2, latex_x = tt{3}; end
  if numel(tt) > 3, latex_y = tt{4}; end
else
  ttext = tt;
end

% remove the title
varargin = { varargin{2:end} };

for i = 1:numel(varargin)
  if i == 1
    x_vals = varargin{1};
  elseif i == 2
    v = varargin{2};
    if ischar(v)
      x_label = v;
    else
      y_vals = v;
    end
  elseif i == 3
    v = varargin{3};
    if ischar(v)
      y_label = v;
    else
      y_vals = v;
    end
  elseif i == 4
    y_label = varargin{4};
  end
end

plot(x_vals, y_vals);
setaxis(x_vals, y_vals);

function latexify(func, txt, option)
  if option == 0
    func(txt);
  elseif option == 1
    func(txt, 'interpreter', 'latex');
  else
    func(['$$' txt '$$'], 'interpreter', 'latex');
  end
end

latexify(@xlabel, x_label, latex_x);

latexify(@ylabel, y_label, latex_y);

latexify(@title, ttext, latex_title);

end
