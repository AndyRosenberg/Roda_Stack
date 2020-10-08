
import NewUserForm from './users/NewUserForm.vue';
import EditUserForm from './users/EditUserForm.vue';
import SignIn from './logins/SignIn.vue';
import ForgotPW from './logins/Forgot.vue';
import ResetPW from './logins/Reset.vue';
import Flash from "./flash/Flash.vue";

export default {
  'new-user-form': NewUserForm,
  'edit-user-form': EditUserForm,
  'sign-in': SignIn,
  'forgot-password': ForgotPW,
  'reset-password': ResetPW,
  'flash-message': Flash,
}