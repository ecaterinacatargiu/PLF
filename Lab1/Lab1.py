class Nod:
    def __init__(self, e):
        self.e = e
        self.urm = None


class Lista:
    def __init__(self):
        self.prim = None

    def sublist(self):
        newList = Lista()
        newList.prim = self.prim.urm

        return newList


'''
crearea unei liste din valori citite pana la 0
'''


def creareLista():
    lista = Lista()
    lista.prim = creareLista_rec()
    return lista


def creareLista_rec():
    x = int(input("x="))
    if x == 0:
        return None
    else:
        nod = Nod(x)
        nod.urm = creareLista_rec()
        return nod


'''
tiparirea elementelor unei liste
'''


def tipar(lista):
    tipar_rec(lista.prim)

def tipar_rec(nod):
    if nod != None:
        print(nod.e)
        tipar_rec(nod.urm)

def isEmpty(list):
    return list.prim == None


def getFirst(lst):
    if(lst.prim!=None):
        return lst.prim

#def getSecond(lst):
 #   if(lst.prim!=None)
#        reuturn lst.prim.urm

def removeEl(lst):
    if(lst != None and lst.prim!=None):
        lst.prim=lst.prim.urm
        return lst




def lcm(lst):
    return lcRec(lst,1)

def gcd(a,b):
    if(b!=0):
        return gcd(b,a % b)
    else:
        return a

'''def lcmRec(lst, cMult):
    #if(lst==None):
    if isEmpty(lst):
        return cMult
    else:
        firstEL = getFirst(lst).e
        cMult=(firstEL*cMult)//gcd(firstEL, cMult)
        lcmRec(removeEl(lst), cMult)'''

def lcRec(lst, cMult):
    if isEmpty(lst):
        return cMult
    else:
        cMult = (cMult*(getFirst(lst).e)//gcd(cMult,getFirst(lst).e))
        return lcRec(removeEl(lst),cMult)

def nestrepl(lst, e1, e2):

    if(isEmpty(lst)):
        return
    primul = lst.prim
    if primul.e == e1:
        primul.e = e2
        nestrepl(lst.sublist(), e1, e2)
    else:
        nestrepl(lst.sublist(), e1, e2)


def main():
    list = creareLista()
    e1= int(input("e1: "))
    e2 = int(input("e2: "))
    nestrepl(list, e1,e2)
    print("New list: ")
    tipar(list)
    print("Lcm: ")
    print(lcm(list))


main()
#print(lcm)





