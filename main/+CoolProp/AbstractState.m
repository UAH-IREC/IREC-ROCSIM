classdef AbstractState < SwigRef
  methods
    function delete(self)
      if self.swigInd
        CoolPropMATLAB_wrap(181, self);
        self.swigInd=uint64(0);
      end
    end
    function varargout = set_T(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(183, self, varargin{:});
    end
    function varargout = backend_name(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(184, self, varargin{:});
    end
    function varargout = using_mole_fractions(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(185, self, varargin{:});
    end
    function varargout = using_mass_fractions(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(186, self, varargin{:});
    end
    function varargout = using_volu_fractions(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(187, self, varargin{:});
    end
    function varargout = set_mole_fractions(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(188, self, varargin{:});
    end
    function varargout = set_mass_fractions(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(189, self, varargin{:});
    end
    function varargout = set_volu_fractions(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(190, self, varargin{:});
    end
    function varargout = mole_fractions_liquid(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(191, self, varargin{:});
    end
    function varargout = mole_fractions_vapor(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(192, self, varargin{:});
    end
    function varargout = get_mole_fractions(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(193, self, varargin{:});
    end
    function varargout = get_mass_fractions(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(194, self, varargin{:});
    end
    function varargout = update(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(195, self, varargin{:});
    end
    function varargout = update_with_guesses(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(196, self, varargin{:});
    end
    function varargout = available_in_high_level(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(197, self, varargin{:});
    end
    function varargout = fluid_param_string(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(198, self, varargin{:});
    end
    function varargout = fluid_names(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(199, self, varargin{:});
    end
    function varargout = set_binary_interaction_double(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(200, self, varargin{:});
    end
    function varargout = set_binary_interaction_string(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(201, self, varargin{:});
    end
    function varargout = get_binary_interaction_double(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(202, self, varargin{:});
    end
    function varargout = get_binary_interaction_string(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(203, self, varargin{:});
    end
    function varargout = apply_simple_mixing_rule(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(204, self, varargin{:});
    end
    function varargout = clear(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(205, self, varargin{:});
    end
    function varargout = get_reducing_state(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(206, self, varargin{:});
    end
    function varargout = get_state(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(207, self, varargin{:});
    end
    function varargout = Tmin(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(208, self, varargin{:});
    end
    function varargout = Tmax(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(209, self, varargin{:});
    end
    function varargout = pmax(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(210, self, varargin{:});
    end
    function varargout = Ttriple(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(211, self, varargin{:});
    end
    function varargout = phase(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(212, self, varargin{:});
    end
    function varargout = specify_phase(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(213, self, varargin{:});
    end
    function varargout = unspecify_phase(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(214, self, varargin{:});
    end
    function varargout = T_critical(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(215, self, varargin{:});
    end
    function varargout = p_critical(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(216, self, varargin{:});
    end
    function varargout = rhomolar_critical(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(217, self, varargin{:});
    end
    function varargout = rhomass_critical(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(218, self, varargin{:});
    end
    function varargout = all_critical_points(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(219, self, varargin{:});
    end
    function varargout = criticality_contour_values(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(220, self, varargin{:});
    end
    function varargout = tangent_plane_distance(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(221, self, varargin{:});
    end
    function varargout = T_reducing(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(222, self, varargin{:});
    end
    function varargout = rhomolar_reducing(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(223, self, varargin{:});
    end
    function varargout = rhomass_reducing(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(224, self, varargin{:});
    end
    function varargout = p_triple(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(225, self, varargin{:});
    end
    function varargout = name(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(226, self, varargin{:});
    end
    function varargout = dipole_moment(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(227, self, varargin{:});
    end
    function varargout = keyed_output(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(228, self, varargin{:});
    end
    function varargout = trivial_keyed_output(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(229, self, varargin{:});
    end
    function varargout = saturated_liquid_keyed_output(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(230, self, varargin{:});
    end
    function varargout = saturated_vapor_keyed_output(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(231, self, varargin{:});
    end
    function varargout = T(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(232, self, varargin{:});
    end
    function varargout = rhomolar(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(233, self, varargin{:});
    end
    function varargout = rhomass(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(234, self, varargin{:});
    end
    function varargout = p(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(235, self, varargin{:});
    end
    function varargout = Q(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(236, self, varargin{:});
    end
    function varargout = tau(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(237, self, varargin{:});
    end
    function varargout = delta(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(238, self, varargin{:});
    end
    function varargout = molar_mass(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(239, self, varargin{:});
    end
    function varargout = acentric_factor(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(240, self, varargin{:});
    end
    function varargout = gas_constant(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(241, self, varargin{:});
    end
    function varargout = Bvirial(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(242, self, varargin{:});
    end
    function varargout = dBvirial_dT(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(243, self, varargin{:});
    end
    function varargout = Cvirial(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(244, self, varargin{:});
    end
    function varargout = dCvirial_dT(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(245, self, varargin{:});
    end
    function varargout = compressibility_factor(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(246, self, varargin{:});
    end
    function varargout = hmolar(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(247, self, varargin{:});
    end
    function varargout = hmass(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(248, self, varargin{:});
    end
    function varargout = smolar(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(249, self, varargin{:});
    end
    function varargout = smass(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(250, self, varargin{:});
    end
    function varargout = umolar(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(251, self, varargin{:});
    end
    function varargout = umass(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(252, self, varargin{:});
    end
    function varargout = cpmolar(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(253, self, varargin{:});
    end
    function varargout = cpmass(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(254, self, varargin{:});
    end
    function varargout = cp0molar(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(255, self, varargin{:});
    end
    function varargout = cp0mass(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(256, self, varargin{:});
    end
    function varargout = cvmolar(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(257, self, varargin{:});
    end
    function varargout = cvmass(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(258, self, varargin{:});
    end
    function varargout = gibbsmolar(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(259, self, varargin{:});
    end
    function varargout = gibbsmass(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(260, self, varargin{:});
    end
    function varargout = speed_sound(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(261, self, varargin{:});
    end
    function varargout = isothermal_compressibility(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(262, self, varargin{:});
    end
    function varargout = isobaric_expansion_coefficient(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(263, self, varargin{:});
    end
    function varargout = fugacity_coefficient(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(264, self, varargin{:});
    end
    function varargout = fugacity(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(265, self, varargin{:});
    end
    function varargout = chemical_potential(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(266, self, varargin{:});
    end
    function varargout = PIP(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(267, self, varargin{:});
    end
    function varargout = true_critical_point(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(268, self, varargin{:});
    end
    function varargout = ideal_curve(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(269, self, varargin{:});
    end
    function varargout = first_partial_deriv(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(270, self, varargin{:});
    end
    function varargout = second_partial_deriv(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(271, self, varargin{:});
    end
    function varargout = first_saturation_deriv(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(272, self, varargin{:});
    end
    function varargout = second_saturation_deriv(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(273, self, varargin{:});
    end
    function varargout = first_two_phase_deriv(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(274, self, varargin{:});
    end
    function varargout = second_two_phase_deriv(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(275, self, varargin{:});
    end
    function varargout = first_two_phase_deriv_splined(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(276, self, varargin{:});
    end
    function varargout = build_phase_envelope(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(277, self, varargin{:});
    end
    function varargout = get_phase_envelope_data(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(278, self, varargin{:});
    end
    function varargout = has_melting_line(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(279, self, varargin{:});
    end
    function varargout = melting_line(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(280, self, varargin{:});
    end
    function varargout = saturation_ancillary(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(281, self, varargin{:});
    end
    function varargout = viscosity(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(282, self, varargin{:});
    end
    function varargout = viscosity_contributions(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(283, self, varargin{:});
    end
    function varargout = conductivity(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(284, self, varargin{:});
    end
    function varargout = conductivity_contributions(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(285, self, varargin{:});
    end
    function varargout = surface_tension(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(286, self, varargin{:});
    end
    function varargout = Prandtl(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(287, self, varargin{:});
    end
    function varargout = conformal_state(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(288, self, varargin{:});
    end
    function varargout = change_EOS(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(289, self, varargin{:});
    end
    function varargout = alpha0(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(290, self, varargin{:});
    end
    function varargout = dalpha0_dDelta(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(291, self, varargin{:});
    end
    function varargout = dalpha0_dTau(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(292, self, varargin{:});
    end
    function varargout = d2alpha0_dDelta2(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(293, self, varargin{:});
    end
    function varargout = d2alpha0_dDelta_dTau(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(294, self, varargin{:});
    end
    function varargout = d2alpha0_dTau2(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(295, self, varargin{:});
    end
    function varargout = d3alpha0_dTau3(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(296, self, varargin{:});
    end
    function varargout = d3alpha0_dDelta_dTau2(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(297, self, varargin{:});
    end
    function varargout = d3alpha0_dDelta2_dTau(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(298, self, varargin{:});
    end
    function varargout = d3alpha0_dDelta3(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(299, self, varargin{:});
    end
    function varargout = alphar(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(300, self, varargin{:});
    end
    function varargout = dalphar_dDelta(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(301, self, varargin{:});
    end
    function varargout = dalphar_dTau(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(302, self, varargin{:});
    end
    function varargout = d2alphar_dDelta2(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(303, self, varargin{:});
    end
    function varargout = d2alphar_dDelta_dTau(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(304, self, varargin{:});
    end
    function varargout = d2alphar_dTau2(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(305, self, varargin{:});
    end
    function varargout = d3alphar_dDelta3(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(306, self, varargin{:});
    end
    function varargout = d3alphar_dDelta2_dTau(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(307, self, varargin{:});
    end
    function varargout = d3alphar_dDelta_dTau2(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(308, self, varargin{:});
    end
    function varargout = d3alphar_dTau3(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(309, self, varargin{:});
    end
    function varargout = d4alphar_dDelta4(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(310, self, varargin{:});
    end
    function varargout = d4alphar_dDelta3_dTau(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(311, self, varargin{:});
    end
    function varargout = d4alphar_dDelta2_dTau2(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(312, self, varargin{:});
    end
    function varargout = d4alphar_dDelta_dTau3(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(313, self, varargin{:});
    end
    function varargout = d4alphar_dTau4(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(314, self, varargin{:});
    end
    function self = AbstractState(varargin)
      if nargin~=1 || ~ischar(varargin{1}) || ~strcmp(varargin{1},'_swigCreate')
        error('No matching constructor');
      end
    end
  end
  methods(Static)
    function varargout = factory(varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(182, varargin{:});
    end
  end
end
