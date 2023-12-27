enum RouteNames {
   splashScreen('/'),
   homeScreen('/home'),
   loginScreen('/login'),
   userRegisterScreen('/user-registration'),
   barbershopRegisterScreen('/register/barbershop'),
   homeCustomerScreen('/home-customer'),
   homeAdmScreen('/adm'),
   emailVerificationScreen('/email-verification'),
   customerRegistrationScreen('/customer-registration'),
   forgotPasswordScreen('/forgot-password'),
   checkEmailScreen('/check-email/:email'); 

  final String routeName;
  const RouteNames(this.routeName);
}
