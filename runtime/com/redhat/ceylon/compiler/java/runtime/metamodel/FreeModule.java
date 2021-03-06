package com.redhat.ceylon.compiler.java.runtime.metamodel;

import java.util.List;

import ceylon.language.SequenceBuilder;
import ceylon.language.Sequential;
import ceylon.language.Annotated$impl;
import ceylon.language.meta.declaration.AnnotatedDeclaration$impl;
import ceylon.language.meta.declaration.Declaration$impl;
import ceylon.language.meta.declaration.Import;
import ceylon.language.meta.declaration.Module$impl;
import ceylon.language.meta.declaration.Package;

import com.redhat.ceylon.compiler.java.Util;
import com.redhat.ceylon.compiler.java.metadata.Ignore;
import com.redhat.ceylon.compiler.java.metadata.Name;
import com.redhat.ceylon.compiler.java.metadata.TypeInfo;
import com.redhat.ceylon.compiler.java.metadata.TypeParameter;
import com.redhat.ceylon.compiler.java.metadata.TypeParameters;
import com.redhat.ceylon.compiler.java.runtime.model.ReifiedType;
import com.redhat.ceylon.compiler.java.runtime.model.TypeDescriptor;

public class FreeModule implements ceylon.language.meta.declaration.Module,
        AnnotationBearing,
        ReifiedType {

    @Ignore
    public static final TypeDescriptor $TypeDescriptor$ = TypeDescriptor.klass(FreeModule.class);
    protected com.redhat.ceylon.compiler.typechecker.model.Module declaration;
    private Sequential<? extends Package> packages;
    private Sequential<? extends Import> dependencies;
    
    public FreeModule(com.redhat.ceylon.compiler.typechecker.model.Module declaration) {
        this.declaration = declaration;
    }

    @Override
    @Ignore
    public Declaration$impl $ceylon$language$meta$declaration$Declaration$impl() {
        return null;
    }

    @Override
    @Ignore
    public AnnotatedDeclaration$impl $ceylon$language$meta$declaration$AnnotatedDeclaration$impl() {
        return null;
    }

    @Override
    @Ignore
    public Module$impl $ceylon$language$meta$declaration$Module$impl() {
        return null;
    }
    
    @Override
    @Ignore
    public Annotated$impl $ceylon$language$Annotated$impl() {
        return null;
    }
    
    @Override
    @Ignore
    public java.lang.annotation.Annotation[] $getJavaAnnotations$() {
        return Metamodel.getJavaClass(declaration).getAnnotations();
    }

    @Override
    @TypeInfo("ceylon.language::Sequential<Annotation>")
    @TypeParameters(@TypeParameter(value = "Annotation", satisfies = "ceylon.language::Annotation"))
    public <Annotation extends ceylon.language.Annotation> Sequential<? extends Annotation> annotations(@Ignore TypeDescriptor $reifiedAnnotation) {
        return Metamodel.annotations($reifiedAnnotation, this);
    }

    @Override
    @TypeInfo("ceylon.language::Sequential<ceylon.language.meta.declaration::Package>")
    public Sequential<? extends Package> getMembers() {
        // no need to synchronise as concurrent invocations should get the same array back
        if(this.packages == null){
            List<com.redhat.ceylon.compiler.typechecker.model.Package> modelPackages = declaration.getPackages();
            Package[] packages = new Package[modelPackages.size()];
            for(int i=0;i<packages.length;i++){
                packages[i] = Metamodel.getOrCreateMetamodel(modelPackages.get(i));
            }
            this.packages = Util.sequentialInstance(Package.$TypeDescriptor$, packages);
        }
        return this.packages;
    }

    @Override
    @TypeInfo("ceylon.language::Null|ceylon.language.meta.declaration::Package")
    public Package findPackage(@Name("name") String name) {
        com.redhat.ceylon.compiler.typechecker.model.Package pkg = declaration.getDirectPackage(name);
        return pkg == null ? null : Metamodel.getOrCreateMetamodel(pkg);
    }

    @Override
    @TypeInfo("ceylon.language::Null|ceylon.language.meta.declaration::Package")
    public Package findImportedPackage(@Name("name") String name) {
        com.redhat.ceylon.compiler.typechecker.model.Package pkg = declaration.getPackage(name);
        return pkg == null ? null : Metamodel.getOrCreateMetamodel(pkg);
    }

    @Override
    @TypeInfo("ceylon.language::Sequential<ceylon.language.meta.declaration::Import>")
    public Sequential<? extends Import> getDependencies() {
        // no need to synchronise as concurrent invocations should get the same array back
        if(this.dependencies == null){
            List<com.redhat.ceylon.compiler.typechecker.model.ModuleImport> modelImports = declaration.getImports();
            //FreeImport[] imports = new FreeImport[modelImports.size()];
            SequenceBuilder<FreeImport> sb = new SequenceBuilder<>(Import.$TypeDescriptor$, modelImports.size()-1);
            for(com.redhat.ceylon.compiler.typechecker.model.ModuleImport moduleImport : modelImports){
                if ("ceylon.language".equals(moduleImport.getModule().getNameAsString())) {
                    continue;
                }
                sb.append(new FreeImport(this, moduleImport));
            }
            this.dependencies = sb.getSequence();
        }
        return this.dependencies;
    }

    @Override
    @TypeInfo("ceylon.language::String")
    public String getName() {
        return declaration.getNameAsString();
    }

    @Override
    public String getQualifiedName() {
        return getName();
    }

    @Override
    @TypeInfo("ceylon.language::String")
    public String getVersion() {
        return declaration.getVersion();
    }

    @Override
    public int hashCode() {
        int result = 1;
        result = 37 * result + getName().hashCode();
        String version = getVersion();
        result = 37 * result + (version == null ? 0 : version.hashCode());
        return result;
    }
    
    @Override
    public boolean equals(Object obj) {
        if(obj == null)
            return false;
        if(obj == this)
            return true;
        if(obj instanceof ceylon.language.meta.declaration.Module == false)
            return false;
        ceylon.language.meta.declaration.Module other = (ceylon.language.meta.declaration.Module) obj;
        if(!Util.eq(other.getVersion(), getVersion()))
            return false;
        return getName().equals(other.getName());
    }

    @Override
    public String toString() {
        return "module " + getName() + "/" + getVersion();
    }

    @Ignore
    @Override
    public TypeDescriptor $getType$() {
        return $TypeDescriptor$;
    }
}
