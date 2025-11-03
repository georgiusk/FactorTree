mutable struct FactorTree
    value::Int
    left::Union{Int,FactorTree}
    right::Union{Int,FactorTree}
    function FactorTree(v::Int)::FactorTree
       new(v,0,0) #Erstellt ein neues FactorTree-Objekt mit dem Wert v und initialisiert left und right.
    end
end
function isprime(n::Int) #Finde ob die Zahl prime ist oder nicht
    if n<=1 
        return false
    end
    for i=2:n-1 #sqrt(n)+1
        if n%i==0
            return false
        end
    end
    return true
end
function getFactors(t::FactorTree)::Dict{Int, Int}
    dict=Dict{Int, Int}()
    val=t.value #erstellt eine Variable val als iterator mit Anfangswert Wert von t
    divider=2 #erstellt eine variable divider als teiler von val
    while !isprime(val)
        if val%divider==0 #wenn val modulo divider = 0 d.h. val ist ein Faktor
            if !haskey(dict,divider)
                dict[divider]=1
            elseif haskey(dict,divider)
                dict[divider]+=1
            end
            val=Int(val/divider) #dividieren wir val mit divider
            divider=2 #reset divider mit 2
        else
            divider+=1
        end
    end
    if !haskey(dict,val) #addieren sich val selbst nach dict
        dict[val]=1
    elseif haskey(dict,val)
        dict[val]+=1
    end
    return dict
end
function getShape(t::FactorTree)::String
    divider=isqrt(t.value)
    while t.value%divider!=0 #Findet den größten Teiler von t.value und weist ihn x zu.
        divider-=1
    end
    t.left=divider 
    t.right=Int(t.value/divider)
    if (isprime(t.value))||(t.value==1) #Überprüft, ob t.value eine Primzahl ist oder ob es den Wert 1 hat.
        return "p"
    elseif (isprime(t.left)) && (isprime(t.right)) #Überprüft, ob der linke und rechte Nachkomme von t Primzahlen sind.
        return "p2"
    else
        return "f("*getShape(FactorTree(t.left))*"|"*getShape(FactorTree(t.right))*")" #Rekursiv aufrufen
    end
end
function compareShape(t::FactorTree,h::FactorTree)
    return getShape(t)==getShape(h) #Vergleicht die Formen von t und h
end
function computeShapes(n::Int)::Dict{String, Vector{Int}}
    Factors=Dict{String,Vector{Int}}()
    for i=1:1:n
        key=getShape(FactorTree(i)) #Ruft getShape für FactorTree auf.
        if haskey(Factors, key)
            push!(Factors[key],i)
        else
            Factors[key]=[]
            push!(Factors[key],i)
        end
    end
    return Factors #Gibt das aktualisierte Dictionary Factors zurück
end
