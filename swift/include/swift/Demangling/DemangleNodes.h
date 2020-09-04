//===--- DemangleNodes.h - Demangling Tree Metaprogramming ----*- C++ -*-===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
//
// This file defines macros useful for macro-metaprogramming with nodes in
// the demangling tree.
//
//===----------------------------------------------------------------------===//

/// NODE(ID)
///   The node's enumerator value is Node::Kind::ID.

/// CONTEXT_NODE(ID)
///   Nodes that can serve as contexts for other entities.
#ifndef CONTEXT_NODE
#define CONTEXT_NODE(ID) NODE(ID)
#endif

CONTEXT_NODE(Allocator)
CONTEXT_NODE(AnonymousContext)
NODE(AnyProtocolConformanceList)
NODE(ArgumentTuple)
NODE(AssociatedType)
NODE(AssociatedTypeRef)
NODE(AssociatedTypeMetadataAccessor)
NODE(DefaultAssociatedTypeMetadataAccessor)
NODE(AssociatedTypeWitnessTableAccessor)
NODE(BaseWitnessTableAccessor)
NODE(AutoClosureType)
NODE(BoundGenericClass)
NODE(BoundGenericEnum)
NODE(BoundGenericStructure)
NODE(BoundGenericProtocol)
NODE(BoundGenericOtherNominalType)
NODE(BoundGenericTypeAlias)
NODE(BoundGenericFunction)
NODE(BuiltinTypeName)
NODE(CFunctionPointer)
CONTEXT_NODE(Class)
NODE(ClassMetadataBaseOffset)
NODE(ConcreteProtocolConformance)
CONTEXT_NODE(Constructor)
NODE(CoroutineContinuationPrototype)
CONTEXT_NODE(Deallocator)
NODE(DeclContext)
CONTEXT_NODE(DefaultArgumentInitializer)
NODE(DependentAssociatedConformance)
NODE(DependentAssociatedTypeRef)
NODE(DependentGenericConformanceRequirement)
NODE(DependentGenericParamCount)
NODE(DependentGenericParamType)
NODE(DependentGenericSameTypeRequirement)
NODE(DependentGenericLayoutRequirement)
NODE(DependentGenericSignature)
NODE(DependentGenericType)
NODE(DependentMemberType)
NODE(DependentPseudogenericSignature)
NODE(DependentProtocolConformanceRoot)
NODE(DependentProtocolConformanceInherited)
NODE(DependentProtocolConformanceAssociated)
CONTEXT_NODE(Destructor)
CONTEXT_NODE(DidSet)
NODE(DifferentiableFunctionType)
NODE(EscapingDifferentiableFunctionType)
NODE(LinearFunctionType)
NODE(EscapingLinearFunctionType)
NODE(Directness)
NODE(DynamicAttribute)
NODE(DirectMethodReferenceAttribute)
NODE(DynamicSelf)
NODE(DynamicallyReplaceableFunctionImpl)
NODE(DynamicallyReplaceableFunctionKey)
NODE(DynamicallyReplaceableFunctionVar)
CONTEXT_NODE(Enum)
NODE(EnumCase)
NODE(ErrorType)
NODE(EscapingAutoClosureType)
NODE(NoEscapeFunctionType)
NODE(ExistentialMetatype)
CONTEXT_NODE(ExplicitClosure)
CONTEXT_NODE(Extension)
NODE(FieldOffset)
NODE(FullTypeMetadata)
CONTEXT_NODE(Function)
NODE(FunctionSignatureSpecialization)
NODE(FunctionSignatureSpecializationParam)
NODE(FunctionSignatureSpecializationReturn)
NODE(FunctionSignatureSpecializationParamKind)
NODE(FunctionSignatureSpecializationParamPayload)
NODE(FunctionType)
NODE(GenericPartialSpecialization)
NODE(GenericPartialSpecializationNotReAbstracted)
NODE(GenericProtocolWitnessTable)
NODE(GenericProtocolWitnessTableInstantiationFunction)
NODE(ResilientProtocolWitnessTable)
NODE(GenericSpecialization)
NODE(GenericSpecializationNotReAbstracted)
NODE(GenericSpecializationParam)
NODE(InlinedGenericFunction)
NODE(GenericTypeMetadataPattern)
CONTEXT_NODE(Getter)
NODE(Global)
CONTEXT_NODE(GlobalGetter)
NODE(Identifier)
NODE(Index)
CONTEXT_NODE(IVarInitializer)
CONTEXT_NODE(IVarDestroyer)
NODE(ImplDifferentiable)
NODE(ImplLinear)
NODE(ImplEscaping)
NODE(ImplConvention)
NODE(ImplDifferentiability)
NODE(ImplFunctionAttribute)
NODE(ImplFunctionType)
NODE(ImplInvocationSubstitutions)
CONTEXT_NODE(ImplicitClosure)
NODE(ImplParameter)
NODE(ImplPatternSubstitutions)
NODE(ImplResult)
NODE(ImplYield)
NODE(ImplErrorResult)
NODE(InOut)
NODE(InfixOperator)
CONTEXT_NODE(Initializer)
NODE(KeyPathGetterThunkHelper)
NODE(KeyPathSetterThunkHelper)
NODE(KeyPathEqualsThunkHelper)
NODE(KeyPathHashThunkHelper)
NODE(LazyProtocolWitnessTableAccessor)
NODE(LazyProtocolWitnessTableCacheVariable)
NODE(LocalDeclName)
CONTEXT_NODE(MaterializeForSet)
NODE(MergedFunction)
NODE(Metatype)
NODE(MetatypeRepresentation)
NODE(Metaclass)
NODE(MethodLookupFunction)
NODE(ObjCMetadataUpdateFunction)
NODE(ObjCResilientClassStub)
NODE(FullObjCResilientClassStub)
CONTEXT_NODE(ModifyAccessor)
CONTEXT_NODE(Module)
CONTEXT_NODE(NativeOwningAddressor)
CONTEXT_NODE(NativeOwningMutableAddressor)
CONTEXT_NODE(NativePinningAddressor)
CONTEXT_NODE(NativePinningMutableAddressor)
NODE(NominalTypeDescriptor)
NODE(NonObjCAttribute)
NODE(Number)
NODE(ObjCAttribute)
NODE(ObjCBlock)
NODE(EscapingObjCBlock)
CONTEXT_NODE(OtherNominalType)
CONTEXT_NODE(OwningAddressor)
CONTEXT_NODE(OwningMutableAddressor)
NODE(PartialApplyForwarder)
NODE(PartialApplyObjCForwarder)
NODE(PostfixOperator)
NODE(PrefixOperator)
NODE(PrivateDeclName)
NODE(PropertyDescriptor)
CONTEXT_NODE(PropertyWrapperBackingInitializer)
CONTEXT_NODE(Protocol)
CONTEXT_NODE(ProtocolSymbolicReference)
NODE(ProtocolConformance)
NODE(ProtocolConformanceRefInTypeModule)
NODE(ProtocolConformanceRefInProtocolModule)
NODE(ProtocolConformanceRefInOtherModule)
NODE(ProtocolDescriptor)
NODE(ProtocolConformanceDescriptor)
NODE(ProtocolList)
NODE(ProtocolListWithClass)
NODE(ProtocolListWithAnyObject)
NODE(ProtocolSelfConformanceDescriptor)
NODE(ProtocolSelfConformanceWitness)
NODE(ProtocolSelfConformanceWitnessTable)
NODE(ProtocolWitness)
NODE(ProtocolWitnessTable)
NODE(ProtocolWitnessTableAccessor)
NODE(ProtocolWitnessTablePattern)
NODE(ReabstractionThunk)
NODE(ReabstractionThunkHelper)
NODE(ReabstractionThunkHelperWithSelf)
CONTEXT_NODE(ReadAccessor)
NODE(RelatedEntityDeclName)
NODE(RetroactiveConformance)
NODE(ReturnType)
NODE(Shared)
NODE(Owned)
NODE(SILBoxType)
NODE(SILBoxTypeWithLayout)
NODE(SILBoxLayout)
NODE(SILBoxMutableField)
NODE(SILBoxImmutableField)
CONTEXT_NODE(Setter)
NODE(SpecializationPassID)
NODE(IsSerialized)
CONTEXT_NODE(Static)
CONTEXT_NODE(Structure)
CONTEXT_NODE(Subscript)
NODE(Suffix)
NODE(ThinFunctionType)
NODE(Tuple)
NODE(TupleElement)
NODE(TupleElementName)
NODE(Type)
CONTEXT_NODE(TypeSymbolicReference)
CONTEXT_NODE(TypeAlias)
NODE(TypeList)
NODE(TypeMangling)
NODE(TypeMetadata)
NODE(TypeMetadataAccessFunction)
NODE(TypeMetadataCompletionFunction)
NODE(TypeMetadataInstantiationCache)
NODE(TypeMetadataInstantiationFunction)
NODE(TypeMetadataSingletonInitializationCache)
NODE(TypeMetadataDemanglingCache)
NODE(TypeMetadataLazyCache)
NODE(UncurriedFunctionType)
NODE(UnknownIndex)
#define REF_STORAGE(Name, ...) NODE(Name)
#include "ReferenceStorage.h"
CONTEXT_NODE(UnsafeAddressor)
CONTEXT_NODE(UnsafeMutableAddressor)
NODE(ValueWitness)
NODE(ValueWitnessTable)
CONTEXT_NODE(Variable)
NODE(VTableThunk)
NODE(VTableAttribute) // note: old mangling only
CONTEXT_NODE(WillSet)
NODE(ReflectionMetadataBuiltinDescriptor)
NODE(ReflectionMetadataFieldDescriptor)
NODE(ReflectionMetadataAssocTypeDescriptor)
NODE(ReflectionMetadataSuperclassDescriptor)
NODE(GenericTypeParamDecl)
NODE(CurryThunk)
NODE(DispatchThunk)
NODE(MethodDescriptor)
NODE(ProtocolRequirementsBaseDescriptor)
NODE(AssociatedConformanceDescriptor)
NODE(DefaultAssociatedConformanceAccessor)
NODE(BaseConformanceDescriptor)
NODE(AssociatedTypeDescriptor)
NODE(AsyncAnnotation)
NODE(ThrowsAnnotation)
NODE(EmptyList)
NODE(FirstElementMarker)
NODE(VariadicMarker)
NODE(OutlinedBridgedMethod)
NODE(OutlinedCopy)
NODE(OutlinedConsume)
NODE(OutlinedRetain)
NODE(OutlinedRelease)
NODE(OutlinedInitializeWithTake)
NODE(OutlinedInitializeWithCopy)
NODE(OutlinedAssignWithTake)
NODE(OutlinedAssignWithCopy)
NODE(OutlinedDestroy)
NODE(OutlinedVariable)
NODE(AssocTypePath)
NODE(LabelList)
NODE(ModuleDescriptor)
NODE(ExtensionDescriptor)
NODE(AnonymousDescriptor)
NODE(AssociatedTypeGenericParamRef)
NODE(SugaredOptional)
NODE(SugaredArray)
NODE(SugaredDictionary)
NODE(SugaredParen)

// Added in Swift 5.1
NODE(AccessorFunctionReference)
NODE(OpaqueType)
NODE(OpaqueTypeDescriptorSymbolicReference)
NODE(OpaqueTypeDescriptor)
NODE(OpaqueTypeDescriptorAccessor)
NODE(OpaqueTypeDescriptorAccessorImpl)
NODE(OpaqueTypeDescriptorAccessorKey)
NODE(OpaqueTypeDescriptorAccessorVar)
NODE(OpaqueReturnType)
CONTEXT_NODE(OpaqueReturnTypeOf)

// Added in Swift 5.4
NODE(CanonicalSpecializedGenericMetaclass)
NODE(CanonicalSpecializedGenericTypeMetadataAccessFunction)
NODE(MetadataInstantiationCache)
NODE(NoncanonicalSpecializedGenericTypeMetadata)
NODE(NoncanonicalSpecializedGenericTypeMetadataCache)

#undef CONTEXT_NODE
#undef NODE
