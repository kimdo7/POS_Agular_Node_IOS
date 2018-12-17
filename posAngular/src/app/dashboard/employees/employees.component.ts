import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { HttpService } from 'src/app/service/http.service';


@Component({
    selector: 'app-employees',
    templateUrl: './employees.component.html',
    styleUrls: ['./employees.component.css']
})

export class EmployeesComponent implements OnInit {

    admins = []
    employees = [];
    step = 0;
    current_id = undefined


    constructor(private _router: Router, private _httpService: HttpService) { }


    ngOnInit() {
        if (localStorage.getItem('user_id') == null) {
            this._router.navigate(["/"])
        }else{
            this.current_id = localStorage.getItem('user_id')
        }

        this.loadAdmins()
        this.loadEmployees()
    }

    loadAdmins() {
        let observable = this._httpService.getAdmins()
        observable.subscribe(data => {
            this.admins = data['data']
        })
    }

    loadEmployees() {
        let observable = this._httpService.getEmployees()
        observable.subscribe(data => {
            this.employees = data['data']
        })
    }

    onRemoveAdmin(id) {
        let observable = this._httpService.makeEmployeeAccess(id)
        observable.subscribe(data => {

            this.loadAdmins()
            this.loadEmployees()

        })
    }

    onRemoveEmployee(id) {
        let observable = this._httpService.makeCustomerAccess(id)
        observable.subscribe(data => {

            this.loadAdmins()
            this.loadEmployees()

        })
    }

    onGivenAdmin(id) {
        let observable = this._httpService.makeAdminAccess(id)
        observable.subscribe(data => {
            this.loadAdmins()
            this.loadEmployees()

        })
    }

    onDelete(user) {
        var r = confirm(`Danger!!! Would you like to delete ${user.first_name} ${user.last_name}`);
        if (r == true) {
            let observable = this._httpService.deleteUser(user.id)
            observable.subscribe(data => {
                this.loadAdmins()
                this.loadEmployees()
            })
        }
    }

    setStep(index: number) {
        this.step = index;
    }

    nextStep() {
        this.step++;
    }

    prevStep() {
        this.step--;
    }

    // admins: string[] = ['Boots', 'Clogs', 'Loafers', 'Moccasins', 'Sneakers'];
}
