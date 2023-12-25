

class GeneralState {

  static bool isLoading = false;
  static bool iSuccess = false;
  static bool isFailure = false;

  static reset() {
    isFailure=false;
    iSuccess=false;
    isLoading=false;
  }

  static loading() {
    isFailure=false;
    iSuccess=false;
    isLoading=true;
  }

  static success() {
    isFailure=false;
    iSuccess=true;
    isLoading=false;
  }

  static failure() {
    isFailure=true;
    iSuccess=false;
    isLoading=false;
  }

}