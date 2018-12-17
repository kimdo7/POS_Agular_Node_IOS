import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FrontPageComponent } from './front-page/front-page.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { HomeComponent } from './dashboard/home/home.component';
import { CurrentOrdersComponent } from './dashboard/current-orders/current-orders.component';
import { SellsComponent } from './dashboard/sells/sells.component';
import { ItemsComponent } from './dashboard/items/items.component';
import { EmployeesComponent } from './dashboard/employees/employees.component';
import { UsersComponent } from './dashboard/users/users.component';

const routes: Routes = [
    {path: "", component: FrontPageComponent},
    {path: "dashboard", component: DashboardComponent, children:[
        {path: "", component: HomeComponent},
        {path: "home", component: HomeComponent},
        {path: "current", component: CurrentOrdersComponent},
        {path: "sells", component: SellsComponent},
        {path: "items", component: ItemsComponent},
        {path: "employees", component: EmployeesComponent},
        {path: "users", component: UsersComponent},
    ]}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { 
    
}
