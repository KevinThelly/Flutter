class ValidationMixin{
    String validateEmail(String value){
        //return null if valid entry
        //otherwise string wiht error message is returned
        if(!value.contains('@')){
          return 'Please enter a valid email';
        }

        return null;
    }

    String validatePassword(String value){
        if(value.length <4 ){
          return 'Minimum 4 characters';
        }
        return null;
      }
}

