/**
 Helper for formatting the string.
 "My name is {name} andc college name is {collegeName}".format({name: 'Piyush', college: 'NIT, Surat'}) will produce
 My name is Piyush and college name is NIT,Surat
 */
String.prototype.format = function() {
    var str = this.toString();
    if (!arguments.length)
        return str;
    var args = typeof arguments[0],
        args = (("string" == args || "number" == args) ? arguments : arguments[0]);
    for (arg in args)
        str = str.replace(RegExp("\\{" + arg + "\\}", "gi"), args[arg]);
    return str;
};

Array.prototype.notEmpty = function() {
    return this != null && this != undefined && this.length > 0;
};

Array.prototype.delete = function(id) {
    var index = -1, i;
    for (i =0; i < this.length; i++) {
        if (this[i].id == id) {
            break;
        }
    }
    this.splice(i,1);
}

Date.prototype.isBefore = function(date) {
    return moment(this).isBefore(date);
}
Date.prototype.isAfter = function(date) {
    return moment(this).isAfter(date);
}
Date.prototype.isSame = function(date) {
    return moment(this).isSame(date);
};

Array.prototype.find = function(inputItem) {
   for (var i=0; i< this.length; i++) {
       if (this[i].id == inputItem.id) {
           return this[i];
       }
   }
}