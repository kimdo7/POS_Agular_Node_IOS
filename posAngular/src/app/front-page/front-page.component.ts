import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormControl, FormGroupDirective, NgForm } from '@angular/forms';
import { PasswordValidator } from "../../validators.js"
import { ErrorStateMatcher } from '@angular/material';
import { HttpService } from '../service/http.service.js';
import { Router } from '@angular/router';


export class ParentErrorStateMatcher implements ErrorStateMatcher {
    isErrorState(control: FormControl | null, form: FormGroupDirective | NgForm | null): boolean {
        const isSubmitted = !!(form && form.submitted);
        const controlTouched = !!(control && (control.dirty || control.touched));
        const controlInvalid = !!(control && control.invalid);
        const parentInvalid = !!(control && control.parent && control.parent.invalid && (control.parent.dirty || control.parent.touched));

        return isSubmitted || (controlTouched && (controlInvalid || parentInvalid));
    }
}

@Component({
    selector: 'app-front-page',
    templateUrl: './front-page.component.html',
    styleUrls: ['./front-page.component.css']
})
export class FrontPageComponent implements OnInit {
    user = {
        email: undefined,
        password: undefined
    }

    // newUser = {
    //     first_name: undefined,
    //     last_name: undefined,
    //     email: undefined,
    //     password: undefined,
    //     confirmPassword: undefined,
    //     phoneNum: undefined,

    // }

    isLinear = true;
    isOptional = true
    firstFormGroup: FormGroup;
    secondFormGroup: FormGroup;
    thirdFormGroup: FormGroup;
    fourthFormGroup: FormGroup;
    parentErrorStateMatcher = new ParentErrorStateMatcher


    validation_messages = {
        'first_name': [
            { type: 'required', message: 'First Name is required' },
            { type: 'minlength', message: 'Must be at least 2 characters long' },
            { type: 'pattern', message: 'Your username must contain only letters and white space' },
        ],
        'last_name': [
            { type: 'required', message: 'Last Name is required' },
            { type: 'minlength', message: 'Must be at least 2 characters long' },
            { type: 'pattern', message: 'Your username must contain only letters and white space' },
        ],
        'email': [
            { type: 'required', message: 'Email is required' },
            { type: 'pattern', message: 'Invalid Email Address' },
        ],
        'phone': [
            { type: 'required', message: 'Phone is required' },
            { type: 'pattern', message: 'Invalid Phone Number' },
        ],
        'password': [
            { type: 'required', message: 'Password is required' },
            { type: 'minlength', message: 'Must be at least 8 characters long' },
            { type: 'pattern', message: 'Pattern problem' },
        ],
        'confirmPassword': [
            { type: 'required', message: 'Confirm Password is required' },
            { type: 'areEqual', message: 'Password mismatch' }
        ],
    }


    constructor(
        private _formBuilder: FormBuilder,
        private _httpSerivce: HttpService,
        private _router : Router) {

    }

    ngOnInit() {
        if (localStorage.getItem('user_id') == null){
            this._router.navigate(["/"])
        }

        this.firstFormGroup = this._formBuilder.group({
            first_name: new FormControl('', Validators.compose([
                Validators.required,
                Validators.minLength(2),
                Validators.pattern('^[A-Za-z ]+$')
            ])),
            last_name: new FormControl('', Validators.compose([
                Validators.required,
                Validators.minLength(2),
                Validators.pattern('^[A-Za-z ]+$')
            ])),
        });
        this.secondFormGroup = this._formBuilder.group({
            email: new FormControl('', Validators.compose([
                Validators.required,
                Validators.pattern('^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$')
            ]))
        });
        this.thirdFormGroup = this._formBuilder.group({
            phone: new FormControl('', Validators.compose([
                Validators.required,
                Validators.pattern('^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
            ])),
        });
        this.fourthFormGroup = new FormGroup({
            password: new FormControl('', Validators.compose([
                Validators.minLength(5),
                Validators.required,
                Validators.pattern('^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]+$') //this is for the letters (both uppercase and lowercase) and numbers validation
            ])),
            confirmPassword: new FormControl('', Validators.required)
        }, (formGroup: FormGroup) => {
            return PasswordValidator.areEqual(formGroup);
        });

    }


    /*******************************************************
     * pass in the user with email & password
     * try to log in 
     * if error 
     *      return error msg
     * else
     *      log in
     *******************************************************/

    onLogIn() {
        if (this.validEmail(this.user.email) &&
            this.validPass(this.user.password)) {
            let observable = this._httpSerivce.logIn(this.user)
            observable.subscribe(data => {
                console.log(data)
                if (data["data"]["role"] == 1) {
                    localStorage.setItem('user_id', data["data"]["id"] )
                    this._router.navigate(['/dashboard']);
                }

            }
            )
        }
    }

    /*******************************************************
     * Valiation email
     *******************************************************/
    validEmail(email) {
        if (email == undefined)
            return true

        var re = /^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+$/;
        return /^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+$/.test(email);
    }

    /*******************************************************
     * Valid pass
     * pass must > 7
     * pass and confirm pass must match
     *******************************************************/
    validPass(pass) {
        if (pass == undefined) {
            return true
        }
        // else if (this.newUser.password != undefined && this.newUser.confirmPassword != undefined) {
        //     return this.newUser.password == this.newUser.confirmPassword
        // }

        return pass.length > 7
    }

    onSubmit(){
        console.log(this.firstFormGroup.value.first_name)
        console.log(this.firstFormGroup.value.last_name)
        console.log(this.secondFormGroup.value.email)
        console.log(this.thirdFormGroup.value.phone)
        console.log(this.thirdFormGroup.value.password)

        var newUser = {
            'first_name': this.firstFormGroup.value.first_name,
            'last_name': this.firstFormGroup.value.last_name,
            'email' : this.secondFormGroup.value.email,
            'phone': this.thirdFormGroup.value.phone,
            'password': this.fourthFormGroup.value.password
        }
        let observable = this._httpSerivce.createNewUser(newUser)
        observable.subscribe(data => {
            console.log(data)
        })
        alert("Hello")
    }

}
