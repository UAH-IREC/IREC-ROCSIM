classdef GuessesStructure < SwigRef
  methods
    function varargout = T(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(161, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(162, self, varargin{1});
      end
    end
    function varargout = p(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(163, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(164, self, varargin{1});
      end
    end
    function varargout = rhomolar(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(165, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(166, self, varargin{1});
      end
    end
    function varargout = hmolar(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(167, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(168, self, varargin{1});
      end
    end
    function varargout = smolar(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(169, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(170, self, varargin{1});
      end
    end
    function varargout = rhomolar_liq(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(171, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(172, self, varargin{1});
      end
    end
    function varargout = rhomolar_vap(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(173, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(174, self, varargin{1});
      end
    end
    function varargout = x(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(175, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(176, self, varargin{1});
      end
    end
    function varargout = y(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(177, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(178, self, varargin{1});
      end
    end
    function self = GuessesStructure(varargin)
      if nargin~=1 || ~ischar(varargin{1}) || ~strcmp(varargin{1},'_swigCreate')
        % How to get working on C side? Commented out, replaed by hack below
        %self.swigInd = CoolPropMATLAB_wrap(179, varargin{:});
        tmp = CoolPropMATLAB_wrap(179, varargin{:}); % FIXME
        self.swigInd = tmp.swigInd;
        tmp.swigInd = uint64(0);
      end
    end
    function delete(self)
      if self.swigInd
        CoolPropMATLAB_wrap(180, self);
        self.swigInd=uint64(0);
      end
    end
  end
  methods(Static)
  end
end
