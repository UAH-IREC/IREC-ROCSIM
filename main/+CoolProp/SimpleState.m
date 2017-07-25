classdef SimpleState < SwigRef
  methods
    function varargout = rhomolar(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(119, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(120, self, varargin{1});
      end
    end
    function varargout = T(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(121, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(122, self, varargin{1});
      end
    end
    function varargout = p(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(123, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(124, self, varargin{1});
      end
    end
    function varargout = hmolar(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(125, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(126, self, varargin{1});
      end
    end
    function varargout = smolar(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(127, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(128, self, varargin{1});
      end
    end
    function varargout = umolar(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(129, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(130, self, varargin{1});
      end
    end
    function varargout = Q(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(131, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(132, self, varargin{1});
      end
    end
    function self = SimpleState(varargin)
      if nargin~=1 || ~ischar(varargin{1}) || ~strcmp(varargin{1},'_swigCreate')
        % How to get working on C side? Commented out, replaed by hack below
        %self.swigInd = CoolPropMATLAB_wrap(133, varargin{:});
        tmp = CoolPropMATLAB_wrap(133, varargin{:}); % FIXME
        self.swigInd = tmp.swigInd;
        tmp.swigInd = uint64(0);
      end
    end
    function varargout = fill(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(134, self, varargin{:});
    end
    function varargout = is_valid(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(135, self, varargin{:});
    end
    function delete(self)
      if self.swigInd
        CoolPropMATLAB_wrap(136, self);
        self.swigInd=uint64(0);
      end
    end
  end
  methods(Static)
  end
end
