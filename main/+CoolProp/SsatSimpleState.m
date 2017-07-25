classdef SsatSimpleState < CoolProp.SimpleState
  methods
    function varargout = exists(self, varargin)
      narginchk(1, 2)
      if nargin==1
        nargoutchk(0, 1)
        varargout{1} = CoolPropMATLAB_wrap(141, self);
      else
        nargoutchk(0, 0)
        CoolPropMATLAB_wrap(142, self, varargin{1});
      end
    end
    function self = SsatSimpleState(varargin)
      self@CoolProp.SimpleState('_swigCreate');
      if nargin~=1 || ~ischar(varargin{1}) || ~strcmp(varargin{1},'_swigCreate')
        % How to get working on C side? Commented out, replaed by hack below
        %self.swigInd = CoolPropMATLAB_wrap(143, varargin{:});
        tmp = CoolPropMATLAB_wrap(143, varargin{:}); % FIXME
        self.swigInd = tmp.swigInd;
        tmp.swigInd = uint64(0);
      end
    end
    function delete(self)
      if self.swigInd
        CoolPropMATLAB_wrap(144, self);
        self.swigInd=uint64(0);
      end
    end
  end
  methods(Static)
    function v = SSAT_MAX_NOT_SET()
      persistent vInitialized;
      if isempty(vInitialized)
        vInitialized = CoolPropMATLAB_wrap(0, 0);
      end
      v = vInitialized;
    end
    function v = SSAT_MAX_DOESNT_EXIST()
      persistent vInitialized;
      if isempty(vInitialized)
        vInitialized = CoolPropMATLAB_wrap(0, 1);
      end
      v = vInitialized;
    end
    function v = SSAT_MAX_DOES_EXIST()
      persistent vInitialized;
      if isempty(vInitialized)
        vInitialized = CoolPropMATLAB_wrap(0, 2);
      end
      v = vInitialized;
    end
  end
end
