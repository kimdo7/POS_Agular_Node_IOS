import { Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator, MatSort, MatTableDataSource } from '@angular/material';
import { Router } from '@angular/router';
import { HttpService } from 'src/app/service/http.service';

export interface UserData {
    id: string;
    name: string;
    email: string;
    phone: string;
    role: number;
    // color: string;
}

@Component({
    selector: 'app-users',
    templateUrl: './users.component.html',
    styleUrls: ['./users.component.css']
})

export class UsersComponent implements OnInit {
    displayedColumns: string[] = ['name', 'email', 'phone', 'progress', 'color'];
    dataSource: MatTableDataSource<UserData>;
    current_id = undefined

    @ViewChild(MatPaginator) paginator: MatPaginator;
    @ViewChild(MatSort) sort: MatSort;

    constructor(private _router: Router, private _httpSerivce: HttpService) {
    }

    ngOnInit() {
        if (localStorage.getItem('user_id') == null) {
            this._router.navigate(["/"])
        } else {
            this.current_id = localStorage.getItem('user_id')
        }


        this.reload()


    }
    reload() {
        let observable = this._httpSerivce.getUsers()
        observable.subscribe(data => {
            var users = []
            for (var i in data["data"]) {
                users.push(createNewUser(data["data"][i]))
            }
            this.dataSource = new MatTableDataSource(users);
            this.dataSource.paginator = this.paginator;
            this.dataSource.sort = this.sort;
        })
    }


    makeAdmin(id) {
        let observable = this._httpSerivce.makeAdminAccess(id)
        observable.subscribe(data => {
            this.reload()
        })
    }

    makeEmployee(id) {
        if (id == this.current_id) {
            return
        }


        let observable = this._httpSerivce.makeEmployeeAccess(id)
        observable.subscribe(data => {
            this.reload()
        })
    }

    makeCustomer(id) {
        if (id == this.current_id) {
            return
        }
        let observable = this._httpSerivce.makeCustomerAccess(id)
        observable.subscribe(data => {
            this.reload()
        })
    }

    onDelete(user) {
        var r = confirm(`Danger!!! Would you like to delete ${user.name}`);
        if (r == true) {
            let observable = this._httpSerivce.deleteUser(user.id)
            observable.subscribe(data => {
                this.reload()
            })
        }
    }


    applyFilter(filterValue: string) {
        this.dataSource.filter = filterValue.trim().toLowerCase();

        if (this.dataSource.paginator) {
            this.dataSource.paginator.firstPage();
        }
    }
}

/** Builds and returns a new User. */
function createNewUser(obj): UserData {

    return {
        id: obj.id,
        name: obj.first_name + ' ' + obj.last_name,
        phone: obj.phone_number,
        email: obj.email,
        role: obj.role

    };
}
