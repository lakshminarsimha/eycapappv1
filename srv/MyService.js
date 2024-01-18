module.exports=(cds)=>{
    cds.on('hello',(req)=>{
        return "Welcome  "+req.data.name+" to my CAPM World!!!";
    });
    const { ReadEmployeeSrv }=cds.entities;
    cds.on("READ",ReadEmployeeSrv,()=>{
        //push some data into employeeSet
        let aempData=[];
        aempData.push({
            "ID": "02BD2137-0890-1EEA-A6C2-BB55C198E8AB",
            "nameFirst": "Nemp1",
            "nameMiddle": null,
            "nameLast": "emp1last",
        });
        aempData.push({
            "ID": "02BD2137-0890-1EEA-A6C2-BB55C198E8KB",
            "nameFirst": "Nemp2",
            "nameMiddle": null,
            "nameLast": "emp2last",
        });
        return aempData;
    });
}