-- Necessary workaround to make sure alerts use a non-secure mixin.
-- Will otherwise freeze UI in Era
-- Shamelessly taken from Gargul 
-- https://github.com/papa-smurf/Gargul/blob/master/Classes/Alerts.lua
CLM_ContainedAlertFrameMixin = {}
CLM_ContainedAlertFrameMixin.OnPostShow = ContainedAlertFrameMixin.OnPostShow
CLM_ContainedAlertFrameMixin.OnPostHide = ContainedAlertFrameMixin.OnPostHide
CLM_ContainedAlertFrameMixin.SetAlertContainer = ContainedAlertFrameMixin.SetAlertContainer
CLM_ContainedAlertFrameMixin.GetAlertContainer = ContainedAlertFrameMixin.GetAlertContainer
CLM_ContainedAlertFrameMixin.OnManagedAlertFrameVisibilityChanged = ContainedAlertFrameMixin.OnManagedAlertFrameVisibilityChanged
CLM_ContainedAlertFrameMixin.ManagesOwnOutroAnimation = ContainedAlertFrameMixin.ManagesOwnOutroAnimation
CLM_ContainedAlertFrameMixin.SetExternallyManagedOutroAnimation = ContainedAlertFrameMixin.SetExternallyManagedOutroAnimation