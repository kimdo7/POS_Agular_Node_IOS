import { MatButtonModule, MatCheckboxModule, MatToolbarModule, MatIconModule, MatStepperModule, MatFormFieldModule, MatInputModule, MatTreeModule, MatProgressBarModule, MatAccordion, MatExpansionModule, MatDatepickerModule, MatListModule, MatPaginatorModule, MatTableModule, MatOptionModule, MatSelectModule } from '@angular/material'
import { NgModule } from '@angular/core';

@NgModule({
    imports: [ MatOptionModule, MatSelectModule, MatTableModule, MatPaginatorModule, MatListModule, MatDatepickerModule, MatExpansionModule, MatProgressBarModule, MatTreeModule ,MatInputModule, MatFormFieldModule, MatButtonModule, MatCheckboxModule, MatToolbarModule, MatIconModule, MatStepperModule],
    exports: [ MatOptionModule, MatSelectModule, MatTableModule, MatPaginatorModule, MatListModule, MatDatepickerModule, MatExpansionModule, MatProgressBarModule, MatTreeModule ,MatInputModule, MatFormFieldModule, MatButtonModule, MatCheckboxModule, MatToolbarModule, MatIconModule, MatStepperModule],
})

export class MaterialModule {

}